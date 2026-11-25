package com.forgetrace.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

@Slf4j
@Configuration
@EnableAsync
@EnableScheduling
public class AsyncConfig {

    @Bean(name = "notificationExecutor", destroyMethod = "shutdown")
    public ExecutorService notificationExecutor() {
        ThreadFactory threadFactory = new ThreadFactory() {
            private final AtomicInteger counter = new AtomicInteger(1);

            @Override
            public Thread newThread(Runnable task) {
                Thread thread = new Thread(task, "notify-" + counter.getAndIncrement());
                thread.setDaemon(true);
                return thread;
            }
        };
        log.info("Starting notification thread pool (2-4 threads, queue 200)");
        return new ThreadPoolExecutor(
                2,                              // core threads
                4,                              // maximum threads
                60, TimeUnit.SECONDS,           // idle extra threads stop after 60s
                new ArrayBlockingQueue<>(200),  // bounded waiting queue
                threadFactory,
                new ThreadPoolExecutor.CallerRunsPolicy());
    }

    @Bean(name = "taskExecutor")
    public ThreadPoolTaskExecutor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(2);
        executor.setMaxPoolSize(4);
        executor.setQueueCapacity(50);
        executor.setThreadNamePrefix("task-");
        executor.setWaitForTasksToCompleteOnShutdown(true);
        executor.setAwaitTerminationSeconds(20);
        return executor;
    }
}