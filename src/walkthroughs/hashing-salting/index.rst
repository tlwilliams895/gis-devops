:orphan:
.. _walkthrough-hashing-salting:

=====================================
Walkthrough: Hashing and Salting Passwords
=====================================

Setup
-----

1. Checkout the ``rest-walkthrough`` branch of ``https://gitlab.com/LaunchCodeTraining/launchcart``
2. Create and checkout a **feature branch** named ``securely-hash-passwords``

What's the Status?
---------------
1. Run tests to see current status
2. Search for any ``//TODO`` comments
3. We need to make sure that passwords are hashed properly when stored in the database

Implement Secure Password Hashing using BCrypt
##############################################

3. Search for a Spring Security implementation of BCrypt
4. Add **Spring Security** dependency to ``build.gradle``::

    dependencies {
	    compile('org.springframework.security:spring-security-crypto')
        //more dependencies will be listed above or below...
    }

Use the BCryptPasswordEncoder Class
#####################################

5. Use ``BCryptPasswordEncoder.encode`` in the ``User.java`` contructor::

    public User(String username, String password) {
        this.username = username;
        this.pwHash = hashPassword(password);
    }

    private static String hashPassword(String password) {
        return encoder.encode(password);
    }

6. Update ``isMatchingPassword(String password)``::

    public boolean isMatchingPassword(String password) {
        return encoder.matches(password, this.pwHash);
    }

Let's see if it works!
######################
7. Make sure the tests pass
8. Run ``bootRun`` and see if you can register (register a few users)
9. Verify what the hashed and salted password looks like in the database

Quiz
#########
* Where is the salt stored?

Resources
---------
 * `OWASP Hashing Guidelines <https://www.owasp.org/index.php/Password_Storage_Cheat_Sheet>`_
 * `Spring Security - BCrypt documentation <https://docs.spring.io/spring-security/site/docs/5.0.7.RELEASE/reference/htmlsingle/#spring-security-crypto-passwordencoders>`_
 * `Spring Security - BCrypt source code <https://github.com/spring-projects/spring-security/blob/5888a3f6b7e9f56e5d47ecbea3444209c713e3bf/crypto/src/main/java/org/springframework/security/crypto/bcrypt/BCryptPasswordEncoder.java>`_
 * `In Depth Background and Guidance for Hashing <https://crackstation.net/hashing-security.htm>`_
 * `Bcrypt <https://en.wikipedia.org/wiki/Bcrypt>`_
