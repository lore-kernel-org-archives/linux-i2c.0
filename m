From: "Trilok Soni" <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: New style I2C driver for KXSD9 accelerometer
Date: Mon, 22 Sep 2008 10:38:40 -0700
Message-ID: <5d5443650809221038u7bece6fco2a123c7c85014318@mail.gmail.com>
References: <20125.80062.qm@web7902.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20125.80062.qm-lNdE0ozIhWIn1dgYqARqB/xNefe2kvS0AL8bYrjMMd8@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Varun,

On Fri, Sep 19, 2008 at 8:21 PM, varun mahajan <invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org> wrote:
> Hi,
>
>
>
> I m implementing a driver for accelerometer KXSD9 in linux kernel 2.6.24.7
> for OMAP-3430. KXSD9 sensor will be connected to the i2c bus so it will be
> an i2c client.

You could implement this under input subsystem itself, like how openmoko
did it.

http://wiki.openmoko.org/wiki/Technical:Accelerometer_Fundamentals
http://wiki.openmoko.org/wiki/Accelerometer_data_retrieval
https://svn.openmoko.org/trunk/src/target/kernel/patches/lis302dl.patch


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
