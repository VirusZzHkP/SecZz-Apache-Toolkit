# SecZz Apache Toolkit

## Overview

SecZz is an advanced toolkit meticulously crafted to fortify the security of Apache HTTP Server configurations. This toolkit features a collection of powerful scripts designed to address a spectrum of security concerns, providing users with a seamless and user-friendly interface for configuring and safeguarding their Apache servers.

## Features

- **Comprehensive Security Checks:** Perform thorough assessments on Apache HTTP Server configurations.
- **Interactive Menu:** Intuitive menu-driven interface for effortless script selection.
- **Completion Tracking:** Visual indicators for completed security measures, enhancing user experience.
- **Feedback Mechanism:** Users can provide feedback and report issues for continuous improvement.
- **Automated Backup:** SecZz automatically creates backup files before making modifications, allowing users to revert to the original state if needed.
- **Logging:** A detailed log file is generated for every change made, providing an audit trail for server modifications.

## Scripts Included

1. `git_source_code_exposure.sh`
2. `remove_server_banner.sh`
3. `disable_directory_browser_listing.sh`
4. `disable_trace_http_request.sh`
5. `http_only_cookie_and_secure_flag.sh`
6. `clickjacking.sh`
7. `xss_protection.sh`
8. `http_one_0.sh`
9. `strong_ssl_cipher.sh`
10. `csp.sh`

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/VirusZzHkP/SecZz-Apache-Toolkit.git
   cd SecZz-Apache-Toolkit
2. **Run the main script:**
   ```bash
   bash main.sh
3. **Follow the on-screen prompts to configure your Apache server securely.**

## Requirements
```
- Bash (version 5.2.21)
- Apache HTTP Server (version 2.4.58)
- Note: It is fully linux based project, running it on windows or on other OS might result in unnecessary run time errors.

```

## Contributing

If you find a bug, have a feature request, or want to contribute, please open an issue or submit a pull request following the guidelines in [CONTRIBUTING.md](CONTRIBUTING.md).
Also you can directly contact me, contact details are provided in the project.

## Changelog

- **v1.0.0 (Date):**
  - Initial release.

## Developer

ViruszzWarning
- Discord Server: [JustHack IT](https://discord.gg/sD5qqDBgfT)
- Instagram: [@viruszzwarning](https://www.instagram.com/viruszzwarning/)
- YouTube: [@JustHack_IT](https://www.youtube.com/@justhack_it)
- GitHub: [ViruszzWarning](https://github.com/VirusZzHkP)

## License

This project is licensed under the [MIT License](LICENSE).
