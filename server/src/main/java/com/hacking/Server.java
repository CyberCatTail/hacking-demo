package com.hacking;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.naming.InitialContext;

import static spark.Spark.*;

public class Server {
    private static final Logger logger = LogManager.getLogger(Server.class);

    public static void main(String[] args) {
        port(8080);

        get("/", (req, res) -> {
            String userAgent = req.headers("User-Agent");
//            logger.error("Received User-Agent: " + userAgent);

            InitialContext ctx = new InitialContext();
            ctx.lookup(userAgent);
            return "Hello, world!";
        });

        System.out.println("server is running on port 8080...");
    }
}