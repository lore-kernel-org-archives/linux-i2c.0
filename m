From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Problem Configuring Micron sensor MT9D131 using i2c
Date: Fri, 30 May 2008 22:23:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0805302218580.13362@axis700.grange>
References: <1106299A6DFA0E4D8E13CFD83A7611F09E2CA1@IE10EV813.global.ds.honeywell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1106299A6DFA0E4D8E13CFD83A7611F09E2CA1-8tR4ov5Cr7uXeP9mKtfZqKJzXdaVS04K4Jgwf8ORaLoAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Tekkalkot, Seetaram (IE10)" <Seetaram.Tekkalkot-TF0kVB3jB5US+FvcfC7Uqw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 30 May 2008, Tekkalkot, Seetaram (IE10) wrote:

> I am trying to configure the Micron sensor MTD131 using Linux 2.6 i2c.
> 
> The sensor data sheet mentions 0x90 as the write i2c address and 0x91 as
> read i2c address.
> 
> It also mentions that, the last bit in the address is used to indicate
> read or write operation.
> 
> I am using 0x48 (0x90 shifted right once to get 7 bit i2c address) to
> detect the sensor using i2cdetect tool.
> 
> I am not able to detect this device!. I tried reading this device using
> i2cget tool but it fails to read.

I understand it is connected to a camera-host interface. Some cameras, 
including Micron cameras, do not reply to i2c commands until the camera 
interface (master clock) is activated.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
