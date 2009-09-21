From: Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/1] Better i2c access latencies in high load situations
Date: Mon, 21 Sep 2009 16:14:07 +0300
Message-ID: <1253538847.3157.56.camel@adserver2>
References: <1253099829-17655-1-git-send-email-mika.kuoppala@nokia.com>
	 <20090916134944.4a329d62@hyperion.delvare>
	 <1253102935.13914.7.camel@adserver2>
	 <20090916224328.47e349ab@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090916224328.47e349ab-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, peter.ujfalusi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

On Wed, 2009-09-16 at 22:43 +0200, ext Jean Delvare wrote:
> On Wed, 16 Sep 2009 15:08:55 +0300, Mika Kuoppala wrote:
> > Hi Jean,
> > 
> > On Wed, 2009-09-16 at 13:49 +0200, ext Jean Delvare wrote:
> > 
> > > Can you please define "get a kick"? I don't know anything about
> > > rt_mutex.
> > > 
> > 
> > Sorry for using a vague metaphor. Documentation/rt-mutex.txt explains it
> > as:
> > 
> > "A low priority owner of a rt-mutex inherits the priority of a higher
> > priority waiter until the rt-mutex is released. If the temporarily
> > boosted owner blocks on a rt-mutex itself it propagates the priority
> > boosting to the owner of the other rt_mutex it gets blocked on. The
> > priority boosting is immediately removed once the rt_mutex has been
> > unlocked."
> > 
> > You might want to also take a look at Documentation/rt-mutex-design.txt
> 
> Thanks for the clarification. It all makes a lot of sense. I'll give
> your patch a try, although I don't use I2C for anything time-critical
> so I doubt it makes a difference for me.
> 

I tried to write an application which could show the priority inversion
in action on top of this bus mutex. This application spawns 3 different
child processes each reading one byte of data from a specified slave
address and register. Multiple times. Each child has different priority.
The program to produce these results is at the end of this email.

Without patch: i2c: Prevent priority inversion on top of bus lock
~ # ./a.out
Spawning 3 workers with different priorities
Each worker will read one byte from /dev/i2c-2:0x4b:0x00 10000 times
( 941)PRIO -5     rt  7973 ms lat:  579 min, 313294 max,  795 avg (us)
( 940)PRIO 0      rt 16412 ms lat:  549 min, 796479 max, 1637 avg (us)
( 942)SCHED_FIFO  rt 28148 ms lat:  580 min, 796509 max, 1535 avg (us)
Total run time 28152313 usecs

With patch: i2c: Prevent priority inversion on top of bus lock
~ # ./a.out
Spawning 3 workers with different priorities
Each worker will read one byte from /dev/i2c-2:0x4b:0x00 10000 times
( 960)PRIO -5     rt 13069 ms lat:  580 min,   2472 max, 1302 avg (us)
( 959)PRIO 0      rt 20420 ms lat:  519 min,  16632 max, 2037 avg (us)
( 961)SCHED_FIFO  rt 20420 ms lat:  580 min,   1282 max,  762 avg (us)
Total run time 20424682 usecs

PRIO -5 and PRIO 0 process are busylooping on top of i2c_read and the
SCHED_FIFO is sleeping 1ms after each read for not to steal all cpu
cycles.

As we can see from the results without the patch, the SCHED_FIFO doesn't
have much effect and maximum latencies grow quite large. 

With patch, the maximum latencies are much better. Averages follow the
respective priorities. rt_mutex ensures that the wait time to reaquire
the lock is kept minimum by not letting low priority process to hold it.
This leads to better bus utilization and we finish almost 8 seconds
(~27%) quicker in total. And most importantly the lower priority
processes can't keep the bus mutex for themselves and destroy the
SCHED_FIFO access latencies.

Obviously this benchmark is made to emphasize this problem. Nevertheless
myself and Peter have witnessed this problem in real world workload.

> But now I am curious, why don't we use rt_mutex instead of regular
> mutex all around the place?
> 

What do you mean by all around the place ?

In scope of i2c-core there is no point of converting the client list
lock into rt_mutex due to lack of contention. As there is no free lunch
the rt_mutex struct takes more space and cpu cycles. Also it could be
that rt_mutex is more novel feature and code is converted conservatively
and only when there is real need for it.

I have attached the test program in this mail. You need to change the
slave address and possibly the register to suit your setup. It would be
very interesting to see the numbers from some completely different hw
setup =)

Thanks,
-- Mika

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <sched.h>
#include <linux/i2c-dev.h>

#define READS_PER_CHILD 10000

const char * const i2c_bus_name = "/dev/i2c-2";
const unsigned char i2c_addr = 0x4b;
const unsigned char i2c_reg = 0x00;

struct lat_stats {
	unsigned long min;
	unsigned long max;
	unsigned long long total;
	unsigned long count;
};

static struct lat_stats stats = { 0, 0, 0, 0 };

static void update_lat_stats(unsigned long usecs)
{
	if (stats.count == 0) {
		stats.min = usecs;
		stats.max = usecs;
	} else {
		if (stats.min > usecs)
			stats.min = usecs;
		else if(stats.max < usecs)
			stats.max = usecs;
	}

	stats.total += usecs;
	stats.count++;
}

static void print_lat_stats(const char *s, struct timeval *start, struct
timeval *end)
{
	unsigned long usecs;

	usecs = (end->tv_sec - start->tv_sec) * 1000 * 1000;
	usecs += (end->tv_usec - start->tv_usec);

	printf("(%4d)%-11s rt %5lu ms ", getpid(), s, usecs / 1000);
	printf("lat: %4lu min, %6lu max, %4llu avg (us)\n",
	       stats.min, stats.max, stats.total / stats.count);
}

static int read_timed(int fd, int reg)
{
	int r;
	struct timeval start, end;
	unsigned long usecs;

	gettimeofday(&start, NULL);
	r = i2c_smbus_read_byte_data(fd, reg);
	gettimeofday(&end, NULL);
	if (r < 0) {
		printf("Error reading: %s\n", strerror(errno));
		return r;
	}

	usecs = (end.tv_sec - start.tv_sec) * 1000 * 1000;
	usecs += (end.tv_usec - start.tv_usec);

	update_lat_stats(usecs);

	return r;
}

static int child1_work(int fd)
{
	int r;
	struct timeval start, end;

	printf("pid: %d is PRIO_PROCESS 0\n", getpid());
	r = setpriority(PRIO_PROCESS, 0, 0);

	gettimeofday(&start, NULL);
	while (1) {
		r = read_timed(fd, i2c_reg);
		if (r < 0) {
			printf("Error reading: %s\n", strerror(errno));
			return r;
		}

		if(stats.count >= READS_PER_CHILD)
			break;
	}
	gettimeofday(&end, NULL);

	print_lat_stats("PRIO 0", &start, &end);

	return 0;
}

static int child2_work(int fd)
{
	int r;
	struct timeval start, end;

	printf("pid: %d is PRIO_PROCESS -5\n", getpid());
	r = setpriority(PRIO_PROCESS, 0, -5);

	gettimeofday(&start, NULL);
	while (1) {
		r = read_timed(fd, i2c_reg);
		if (r < 0) {
			printf("Error reading: %s\n", strerror(errno));
			return r;
		}

		if(stats.count >= READS_PER_CHILD)
			break;
	}
	gettimeofday(&end, NULL);

	print_lat_stats("PRIO -5", &start, &end);

	return 0;
}

static int child3_work(int fd)
{
	int r;
	struct timeval start, end;
	struct sched_param sparam = { 0 };

	sparam.sched_priority = 99;

	printf("pid: %d is SCHED_FIFO\n", getpid());
	r = sched_setscheduler(0, SCHED_FIFO, &sparam);
	if (r == -1) {
		printf("Error setting scheduler: %s\n", strerror(errno));
		return r;
	}

	gettimeofday(&start, NULL);
	while (1) {
		r = read_timed(fd, i2c_reg);
		if (r < 0) {
			printf("Error reading: %s\n", strerror(errno));
			return r;
		}

		if(stats.count >= READS_PER_CHILD)
			break;

		/* Give others a chance to do some work */
		usleep(1000);
	}
	gettimeofday(&end, NULL);

	print_lat_stats("SCHED_FIFO", &start, &end);

	return 0;
}

static int fork_work(int (*f)(int fd), int fd)
{
	int r;

	r = fork();
	if (r == 0) {
		r = f(fd);
		if (r != 0)
			printf("Child %d returned with code %d\n", getpid(), r);
		exit(r);
	} else if (r < 0) {
		printf("Error in forking: %s\n", strerror(errno));
		exit(-1);
	}

	return r;
}


int main(int argc, char *argv[])
{
	int fd = -1;
	int r = -1;
	int pid_work1 = 0;
	int pid_work2 = 0;
	int pid_work3 = 0;
	struct timeval start, end;
	unsigned long usecs;


	fd = open(i2c_bus_name, O_RDWR);
	if (fd == -1)
		perror("error opening: ");

	r = ioctl(fd, I2C_SLAVE_FORCE, i2c_addr);
	if (r < 0) {
		printf("Error in I2C_SLAVE_FORCE(0x%02x) ioctl failed: %s\n",
		       i2c_addr, strerror(errno));
		goto out;
	}

	printf("Spawning 3 workers with different priorities\n");
	printf("Each worker will read one byte from %s:0x%02x:0x%02x %d times
\n",
	       i2c_bus_name, i2c_addr, i2c_reg, READS_PER_CHILD);

	gettimeofday(&start, NULL);

	pid_work1 = fork_work(child1_work, fd);
	pid_work2 = fork_work(child2_work, fd);
	pid_work3 = fork_work(child3_work, fd);

	waitpid(pid_work1, NULL, 0);
	waitpid(pid_work2, NULL, 0);
	waitpid(pid_work3, NULL, 0);

	gettimeofday(&end, NULL);

	usecs = (end.tv_sec - start.tv_sec) * 1000 * 1000;
	usecs += (end.tv_usec - start.tv_usec);

	printf("Total run time %lu usecs\n", usecs);

	r = 0;
out:
	if (fd != -1)
		close(fd);

	return r;
}
