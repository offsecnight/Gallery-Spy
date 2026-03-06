# Contributing to Gallery Spy

Thank you for your interest in contributing to Gallery Spy! This document provides guidelines for contributing to the project.

## Code of Conduct

### Our Standards

- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community
- Show empathy towards other community members

### Ethical Guidelines

This project is for **authorized security testing only**. Contributors must:

- ✅ Only contribute features for legitimate security research
- ✅ Follow responsible disclosure practices
- ✅ Respect privacy and legal boundaries
- ❌ Not contribute features designed for illegal surveillance
- ❌ Not promote or encourage unauthorized access

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Description**: Clear description of the bug
- **Steps to Reproduce**: Detailed steps to reproduce the behavior
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Environment**: 
  - OS version
  - Python version
  - Android version (if applicable)
  - APK build details

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Use Case**: Why this enhancement would be useful
- **Proposed Solution**: How you envision it working
- **Alternatives**: Any alternative solutions you've considered
- **Security Impact**: How it affects the tool's security profile

### Pull Requests

1. **Fork the Repository**
   ```bash
   git clone https://github.com/offsecnight/Gallery-Spy.git
   cd Gallery-Spy
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Write clean, readable code
   - Follow existing code style
   - Add comments for complex logic
   - Test your changes thoroughly

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Add: Brief description of your changes"
   ```

5. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**
   - Provide a clear title and description
   - Reference any related issues
   - Explain the changes and their purpose

## Development Guidelines

### Code Style

- **Python**: Follow PEP 8 guidelines
- **Smali**: Maintain consistent formatting
- **Comments**: Use clear, concise comments
- **Variables**: Use descriptive variable names

### Testing

Before submitting:

- ✅ Test APK builds successfully
- ✅ Verify Telegram integration works
- ✅ Test on multiple Android versions (if possible)
- ✅ Check for any errors or warnings

### Documentation

- Update README.md if adding features
- Add inline comments for complex code
- Update usage examples if needed
- Document any new configuration options

## Feature Requests

We welcome feature requests that enhance:

- **Stealth**: Improved evasion techniques
- **Reliability**: Better service persistence
- **Compatibility**: Support for more Android versions
- **Efficiency**: Optimized upload mechanisms
- **Security**: Enhanced operational security

## Areas for Contribution

### High Priority

- [ ] Improved error handling
- [ ] Better network failure recovery
- [ ] Enhanced stealth features
- [ ] Multi-language support
- [ ] Automated testing framework

### Medium Priority

- [ ] Custom upload filters
- [ ] Compression options
- [ ] Alternative exfiltration methods
- [ ] Configuration file support
- [ ] Logging improvements

### Low Priority

- [ ] UI enhancements
- [ ] Additional gallery features
- [ ] Theme customization
- [ ] Statistics tracking

## Security Considerations

When contributing, consider:

- **Detection Avoidance**: Will this increase detection risk?
- **Privacy**: Does this respect user privacy in authorized testing?
- **Legal Compliance**: Is this feature legal for authorized use?
- **Ethical Use**: Can this be misused easily?

## Questions?

If you have questions about contributing:

- Open an issue with the `question` label
- Check existing issues and discussions
- Review the README.md for basic information

## Recognition

Contributors will be recognized in:

- README.md contributors section
- Release notes for significant contributions
- Project documentation

## License

By contributing, you agree that your contributions will be licensed under the Educational Use License 2026.

---

**Thank you for helping make Gallery Spy better for the security research community!**

*Remember: This tool is for authorized security testing only. Always obtain proper authorization before use.*
