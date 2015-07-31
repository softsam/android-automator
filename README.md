# docker-android-automator
Run Android tests on emulators, using appium and robot framework, in a single command line.

Using the docker in docker script made by @jpettazo (https://github.com/jpetazzo/dind).

## Built with
- latest debian
- openjdk 7
- Using the following docker images:
 - softsam/android-*
 - softsam/appium
 - softsam/robotframework-appium

## Running the tests
Assuming you have the following directory structure:

    /home/user/automation
    /home/user/automation/apk
    /home/user/automation/apk/my_app_to_test.apk
    /home/user/automation/robot # my robot framework tests
    /home/user/automation/vnc

Run the following command:

    docker run -i -t --name automator -p 5900:5900 --privileged -v ~/automation:/root/automation -v /var/lib/docker:/var/lib/docker -e LOG=file --name automator softsam/automator

And your robot framework tests in the robot directory will be run on an android emulator.

This will also generate a video of the test session in the vnc directory.