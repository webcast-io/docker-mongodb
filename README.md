tutum-docker-mongodb
====================

Base docker image to run a MongoDB database server


Usage
-----

To create the image `webcastio/mongodb`, execute the following command on the tutum-mongodb folder:

        docker build -t webcastio/mongodb .


Running the MongoDB server
--------------------------

Run the following command to start MongoDB:

        docker run -d -p 27017:27017 -p 28017:28017 webcastio/mongodb

The first time that you run your container, a new random password will be set.
To get the password, check the logs of the container by running:

        docker logs <CONTAINER_ID>

You will see an output like the following:

        ========================================================================
        You can now connect to this MongoDB server using:

            mongo admin -u admin -p 5elsT6KtjrqV --host <host> --port <port>

        Please remember to change the above password as soon as possible!
        ========================================================================

In this case, `5elsT6KtjrqV` is the password set. 
You can then connect to MongoDB:

         mongo admin -u admin -p 5elsT6KtjrqV

Done!


Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a randomly generated one, you can
set the environment variable `MONGODB_PASS` to your specific password when running the container:

        docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" webcastio/mongodb

You can now test your new admin password:

        mongo admin -u admin -p mypass
        curl --user admin:mypass --digest http://localhost:28017/

Run MongoDB without password
----------------------------

If you want run MongoDB without password you can set tge environment variable `AUTH` to specific if you want password or not when running the container:

        docker run -d -p 27017:27017 -p 28017:28017 -e AUTH=no webcastio/mongodb

By default is "yes".

**by http://www.tutum.co**
