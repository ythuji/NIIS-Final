@REM ----------------------------------------------------------------------------
@REM Maven Start Up Batch script
@REM ----------------------------------------------------------------------------

@IF "%DEBUG%" == "" @ECHO OFF
@SETLOCAL

@SET ERROR_CODE=0

@SET MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%
@IF NOT "%MAVEN_PROJECTBASEDIR%"=="" GOTO endDetectBaseDir

@SET EXEC_DIR=%CD%
@SET WDIR=%EXEC_DIR%
:findBaseDir
@IF EXIST "%WDIR%\.mvn" GOTO baseDirFound
@CD ..
@IF "%WDIR%"=="%CD%" GOTO baseDirNotFound
@SET WDIR=%CD%
@GOTO findBaseDir

:baseDirFound
@SET MAVEN_PROJECTBASEDIR=%WDIR%
@CD "%EXEC_DIR%"
@GOTO endDetectBaseDir

:baseDirNotFound
@SET MAVEN_PROJECTBASEDIR=%EXEC_DIR%
@CD "%EXEC_DIR%"

:endDetectBaseDir

@IF NOT EXIST "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties" GOTO fallback

@SET WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"
@SET WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

@IF EXIST %WRAPPER_JAR% GOTO run

@REM Download or fallback to system mvn
:fallback
WHERE mvn >nul 2>nul
@IF %ERRORLEVEL% EQU 0 (
  mvn %*
  @EXIT /B %ERRORLEVEL%
)

@ECHO Error: Could not find or run Maven Wrapper. Please install Maven or run mvn directly.
@EXIT /B 1

:run
@IF NOT "%JAVA_HOME%"=="" GOTO runWithJavaHome
@SET JAVACMD=java
@GOTO runWrapper

:runWithJavaHome
@SET JAVACMD="%JAVA_HOME%\bin\java"

:runWrapper
%JAVACMD% %JAVA_OPTS% -jar %WRAPPER_JAR% %*
@IF %ERRORLEVEL% NEQ 0 GOTO error
@GOTO end

:error
@SET ERROR_CODE=%ERRORLEVEL%

:end
@EXIT /B %ERROR_CODE%
