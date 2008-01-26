From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: DAC5571
Date: Sat, 26 Jan 2008 10:37:47 +0100
Message-ID: <20080126103747.67378666@hyperion.delvare>
References: <Pine.LNX.4.64.0801181524040.14018@galley.ll.mit.edu>
	<20080119174950.1f12f3c0@hyperion.delvare>
	<Pine.LNX.4.64.0801191539500.18738@galley.ll.mit.edu>
	<20080120102335.5cc6a936@hyperion.delvare>
	<Pine.LNX.4.64.0801211310050.18738@galley.ll.mit.edu>
	<20080122150115.03eed1b6@hyperion.delvare>
	<Pine.LNX.4.64.0801231538250.18738@galley.ll.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801231538250.18738-kD1P2mHmSlqz6L9v6lnKkIdd74u8MsAO@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Gary Chambers <gwc-OVIABD91gjs3uPMLIKxrzw@public.gmane.org>
Cc: I2C Mailing List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Gary,

On Wed, 23 Jan 2008 15:48:09 -0500 (EST), Gary Chambers wrote:
> I don't know how beneficial it will be, but I have nearly completed a 
> driver for the DAC5571.  We're currently using Linux 2.4 in our embedded 
> project, but we may soon be upgrading to a 2.6 kernel.

A Linux 2.4 driver obviously won't make it upstream, but a Linux 2.6
driver could. You can always post your code on the i2c list, where it
will be archived for other users to look at. If there are more users
interested, the driver can be reviewed and merged upstream.

> (...)
> We're using the tqm8260Algorithm-bit adapter.  Are you familiar with it?

Never heard of that one, it's not upstream as far as I can see.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
