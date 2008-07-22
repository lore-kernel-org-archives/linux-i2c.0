From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] rtc-pcf8563: Remove client validation
Date: Tue, 22 Jul 2008 12:21:29 -0400
Message-ID: <9e4733910807220921w7c893a94y6a273f86cd3e81e1@mail.gmail.com>
References: <200807021332.15495.laurentp@cse-semaphore.com>
	<20080702133457.05a75e7c@hyperion.delvare>
	<200807221756.44738.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200807221756.44738.laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
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
To: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rod Whitby <rod-wR+KslBqWDsXC2x5gXVKYQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 7/22/08, Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org> wrote:
> Hi Alexander,
>
>
>  On Wednesday 02 July 2008, Jean Delvare wrote:
>  > On Wed, 2 Jul 2008 13:32:14 +0200, Laurent Pinchart wrote:
>  > > Validating clients with black magic register checks doesn't make much sense
>  > > for new-style i2c driver and has been known to fail on valid NXP pcf8563 chips.
>  > > This patch removes the client validation code.

I've hit this same problem with the rtc8564. When the chips are first
installed the registers haven't been initialized. This check makes the
driver load fail which prevents the user space clock app from running
and initializing the registers. The work around was to set the initial
time from uboot.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
