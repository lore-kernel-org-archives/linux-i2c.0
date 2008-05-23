From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Fri, 23 May 2008 11:46:39 +0100
Message-ID: <20080523114639.1705de71@core>
References: <20080522222327.1af72794@core>
	<20080523093545.175c769c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080523093545.175c769c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 23 May 2008 09:35:45 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Alan,
> 
> On Thu, 22 May 2008 22:23:27 +0100, Alan Cox wrote:
> > Signed-off-by: Alan Cox <alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > 
> 
> Description of what the patch does and why it is needed, please. I
> can't apply it without that. My first impression is a patch making the
> code bigger and more complex with no obvious benefit ;)

It pushes the BKL down into the i2c driver. The intention is to remove
the big kernel lock ioctl method from the file_operations structure so
that we can work on getting rid of the big kernel lock for good. It's one
of a series of patches that give me an x86-32 tree with no ->ioctl method
at all.

Similar activity is going on for the other calls made under the BKL the
goal being to push it down into drivers and then eliminate it.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
