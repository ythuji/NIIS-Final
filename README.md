# National Identity Document Issuing System (NIDIS)

A web-based enterprise application for issuing and managing National Identity Documents (National Identity Cards, Driving Licenses, and Passports) built with Spring Boot, Spring Security, Thymeleaf, Spring Data JPA, and Microsoft SQL Server.

---

## 🛠️ Technology Stack

- **Java Version:** Java 21 LTS
- **Framework:** Spring Boot 3.3.x (Spring Data JPA, Spring Security, Spring Mail, Spring Session JDBC)
- **View Engine:** Thymeleaf with Spring Security 6 dialect
- **Database:** Microsoft SQL Server 2019/2022 (`mssql-jdbc`)
- **ORM:** Hibernate 6.x
- **Validation:** Jakarta Validation (`spring-boot-starter-validation`)
- **Boilerplate Reduction:** Project Lombok
- **Build Tool:** Apache Maven 3.9+

---

## 📁 Project Structure

```text
NIIS-Final/
├── pom.xml
├── .gitignore
├── README.md
├── setup_database.sql
├── mvnw
├── mvnw.cmd
├── src/
│   ├── main/
│   │   ├── java/org/nidis/national_identity_document_issuing_system/
│   │   │   ├── NationalIdentityDocumentIssuingSystemApplication.java
│   │   │   ├── config/
│   │   │   │   ├── CustomAuthenticationSuccessHandler.java
│   │   │   │   ├── DataInitializer.java
│   │   │   │   └── SecurityConfig.java
│   │   │   ├── controller/
│   │   │   │   ├── AdminController.java
│   │   │   │   ├── AuthController.java
│   │   │   │   ├── DashboardController.java
│   │   │   │   ├── LicenseController.java
│   │   │   │   ├── NicController.java
│   │   │   │   ├── PassportController.java
│   │   │   │   ├── PaymentController.java
│   │   │   │   └── VerificationController.java
│   │   │   ├── dto/
│   │   │   │   ├── ApplicationCorrectionDto.java
│   │   │   │   ├── DashboardApplicationItem.java
│   │   │   │   ├── LicenseApplicationDto.java
│   │   │   │   ├── LoginDto.java
│   │   │   │   ├── NicApplicationDto.java
│   │   │   │   ├── PassportApplicationDto.java
│   │   │   │   ├── PaymentRequestDto.java
│   │   │   │   ├── RegistrationDto.java
│   │   │   │   ├── ResetPasswordDto.java
│   │   │   │   ├── VerificationDecisionDto.java
│   │   │   │   └── VerificationItemDto.java
│   │   │   ├── model/
│   │   │   │   ├── ApplicationDocument.java
│   │   │   │   ├── AuditLog.java
│   │   │   │   ├── LicenseApplication.java
│   │   │   │   ├── NicApplication.java
│   │   │   │   ├── Notification.java
│   │   │   │   ├── OtpToken.java
│   │   │   │   ├── PassportApplication.java
│   │   │   │   ├── PaymentTransaction.java
│   │   │   │   ├── Role.java
│   │   │   │   ├── User.java
│   │   │   │   └── enums/
│   │   │   │       ├── ApplicationCategory.java
│   │   │   │       ├── ApplicationStatus.java
│   │   │   │       ├── ApplicationType.java
│   │   │   │       ├── OtpType.java
│   │   │   │       ├── PaymentStatus.java
│   │   │   │       └── RoleName.java
│   │   │   ├── pattern/
│   │   │   │   ├── factory/
│   │   │   │   │   └── LicenseApplicationFactory.java
│   │   │   │   ├── observer/
│   │   │   │   │   ├── LicenseAuditLogListener.java
│   │   │   │   │   ├── LicenseEmailNotificationListener.java
│   │   │   │   │   └── LicensePaymentCompletedEvent.java
│   │   │   │   └── strategy/
│   │   │   │       ├── LicenseFeeContext.java
│   │   │   │       ├── LicenseFeeStrategy.java
│   │   │   │       ├── LostLicenseFeeStrategy.java
│   │   │   │       ├── NewLicenseFeeStrategy.java
│   │   │   │       └── RenewalLicenseFeeStrategy.java
│   │   │   ├── repository/
│   │   │   │   ├── ApplicationDocumentRepository.java
│   │   │   │   ├── AuditLogRepository.java
│   │   │   │   ├── LicenseApplicationRepository.java
│   │   │   │   ├── NicApplicationRepository.java
│   │   │   │   ├── NotificationRepository.java
│   │   │   │   ├── OtpTokenRepository.java
│   │   │   │   ├── PassportApplicationRepository.java
│   │   │   │   ├── PaymentTransactionRepository.java
│   │   │   │   ├── RoleRepository.java
│   │   │   │   └── UserRepository.java
│   │   │   ├── service/
│   │   │   │   ├── AdminUserService.java
│   │   │   │   ├── AuditLogService.java
│   │   │   │   ├── AuthService.java
│   │   │   │   ├── DocumentNumberGeneratorService.java
│   │   │   │   ├── EmailService.java
│   │   │   │   ├── FileStorageService.java
│   │   │   │   ├── LicenseService.java
│   │   │   │   ├── NicService.java
│   │   │   │   ├── NotificationService.java
│   │   │   │   ├── OtpService.java
│   │   │   │   ├── PassportService.java
│   │   │   │   ├── PaymentService.java
│   │   │   │   ├── UserService.java
│   │   │   │   └── VerificationService.java
│   │   │   └── validation/
│   │   │       ├── OverEighteen.java
│   │   │       └── OverEighteenValidator.java
│   │   └── resources/
│   │       ├── application.properties
│   │       ├── data.sql
│   │       ├── static/
│   │       │   ├── css/
│   │       │   │   ├── admin.css
│   │       │   │   └── style.css
│   │       │   └── images/
│   │       │       └── nidis-mark.svg
│   │       └── templates/
│   │           ├── admin/
│   │           │   ├── audit-log.html
│   │           │   ├── dashboard.html
│   │           │   └── users.html
│   │           ├── auth/
│   │           │   ├── forgot-password.html
│   │           │   ├── login.html
│   │           │   ├── register.html
│   │           │   ├── reset-password.html
│   │           │   └── verify-otp.html
│   │           ├── dashboard/
│   │           │   └── index.html
│   │           ├── error/
│   │           │   ├── 403.html
│   │           │   ├── 404.html
│   │           │   └── 500.html
│   │           ├── fragments/
│   │           │   ├── admin-topbar.html
│   │           │   ├── footer.html
│   │           │   ├── header.html
│   │           │   └── sidebar.html
│   │           ├── license/
│   │           │   ├── application-detail.html
│   │           │   ├── apply-lost.html
│   │           │   ├── apply-new.html
│   │           │   ├── apply-renewal.html
│   │           │   ├── my-applications.html
│   │           │   └── select-category.html
│   │           ├── nic/
│   │           │   ├── application-detail.html
│   │           │   ├── apply-lost.html
│   │           │   ├── apply-new.html
│   │           │   ├── apply-renewal.html
│   │           │   ├── my-applications.html
│   │           │   └── select-category.html
│   │           ├── passport/
│   │           │   ├── application-detail.html
│   │           │   ├── apply-lost.html
│   │           │   ├── apply-new.html
│   │           │   ├── apply-renewal.html
│   │           │   ├── my-applications.html
│   │           │   └── select-category.html
│   │           ├── payment/
│   │           │   ├── checkout.html
│   │           │   ├── my-payments.html
│   │           │   └── receipt.html
│   │           └── verification/
│   │               ├── queue.html
│   │               └── review.html
│   └── test/
│       └── java/org/nidis/national_identity_document_issuing_system/
│           ├── NationalIdentityDocumentIssuingSystemApplicationTests.java
│           ├── pattern/
│           │   ├── LicenseApplicationFactoryTest.java
│           │   ├── LicenseFeeStrategyTest.java
│           │   └── LicenseObserverPatternTest.java
│           └── service/
│               └── DocumentNumberGeneratorServiceTest.java
```

---

## 🗄️ Database Setup (MS SQL Server)

1. Open **SQL Server Management Studio (SSMS)** or Azure Data Studio.
2. Connect to your MS SQL Server instance (default port `1433`).
3. Open and execute [`setup_database.sql`](setup_database.sql).
   This script will:
   - Create the `NIDIS_DB` database if not present.
   - Create tables (`roles`, `users`, `otp_tokens`, `nic_applications`, `license_applications`, `passport_applications`, `application_documents`, `payment_transactions`, `notifications`, `audit_logs`).
   - Insert default roles (`ROLE_ADMIN`, `ROLE_OFFICER`, `ROLE_CITIZEN`) and seeded accounts.

4. Verify or update connection credentials in [`src/main/resources/application.properties`](src/main/resources/application.properties):
   ```properties
   spring.datasource.url=jdbc:sqlserver://localhost:1433;databaseName=NIDIS_DB;encrypt=true;trustServerCertificate=true;
   spring.datasource.username=sa
   spring.datasource.password=YourStrong@Password123
   ```

---

## 🚀 Running the Project

### Prerequisites
- JDK 21 installed (`java -version`)
- Maven 3.9+ or the included Maven wrapper (`./mvnw` / `mvnw.cmd`)
- MS SQL Server running

### Commands
Build the application:
```bash
./mvnw clean compile
```

Run the application:
```bash
./mvnw spring-boot:run
```
*(On Windows Command Prompt, run `mvnw.cmd spring-boot:run`)*

Access the application in your browser at:
```text
http://localhost:8080
```

---

## 👤 Default Seed Accounts

| Role | Username | Password | Purpose |
|------|----------|----------|---------|
| Administrator | `admin` | `Admin@123` | System management and audit logs |
| Verification Officer | `officer` | `Officer@123` | Identity document approval & verification queue |
| Citizen | `citizen` | `Citizen@123` | Citizen self-service portal |
