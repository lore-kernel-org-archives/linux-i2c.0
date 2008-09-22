From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: New style I2C driver for KXSD9 accelerometer
Date: Mon, 22 Sep 2008 23:43:45 +0100
Message-ID: <20080922224345.GL2716@fluff.org.uk>
References: <20125.80062.qm@web7902.mail.in.yahoo.com>
	<5d5443650809221038u7bece6fco2a123c7c85014318@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d5443650809221038u7bece6fco2a123c7c85014318-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 22, 2008 at 10:38:40AM -0700, Trilok Soni wrote:
> Hi Varun,
> 
> On Fri, Sep 19, 2008 at 8:21 PM, varun mahajan <invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org> wrote:
> > Hi,
> >
> >
> >
> > I m implementing a driver for accelerometer KXSD9 in linux kernel 2.6.24.7
> > for OMAP-3430. KXSD9 sensor will be connected to the i2c bus so it will be
> > an i2c client.
> 
> You could implement this under input subsystem itself, like how openmoko
> did it.

That argument has been had on linux-kernel already, I liked it but the
input subsystem is aparently not good enough for input devices. There
is quite extensive discussion about this if you want to have a look
in the linux-kernel archives.

> http://wiki.openmoko.org/wiki/Technical:Accelerometer_Fundamentals
> http://wiki.openmoko.org/wiki/Accelerometer_data_retrieval
> https://svn.openmoko.org/trunk/src/target/kernel/patches/lis302dl.patch

I've an Bosch SMB380 driver as well, but until someone gets this
sorted out there's not much we can do. I belive one of the posters
to this thread has proposed an alternative, but I have no idea what
the current state of affairs is wrt to getting this or anything
else merged.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
