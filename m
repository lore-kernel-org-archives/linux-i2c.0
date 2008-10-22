From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c driver for Maxim max9485 audio clock
	generator chip
Date: Wed, 22 Oct 2008 12:38:10 -0400
Message-ID: <9e4733910810220938l5530cbb2y310c31e4cd3658e9@mail.gmail.com>
References: <20081021030205.2494.55081.stgit@terra>
	<20081021103607.78ffb4da@hyperion.delvare>
	<9e4733910810211657s5e25e391p5ca6e6f672d115c5@mail.gmail.com>
	<20081022083847.5216472c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081022083847.5216472c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

What you want me to do? Put in a bare .h file for the part? Bare .h
files are much harder to find and reuse. It is also going to force
anyone reusing this part into reading the datasheet and determining
how the part works.


On Wed, Oct 22, 2008 at 2:38 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Tue, 21 Oct 2008 19:57:09 -0400, Jon Smirl wrote:
>> On Tue, Oct 21, 2008 at 4:36 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>> > Honestly I don't see any value in this driver. There's nothing you can
>> > do with it that you couldn't already do without it.
>>
>> I need a driver so that my device tree will bind and tell me the i2c
>> address of the device.
>
> This is rubbish. It's perfectly fine to let the I2C device be
> instantiated from the device tree without having a driver that binds to
> it. The device tree and the instantiated device, not the driver, tell
> you the I2C address of the device.
>
>> We may also build a device in the future with two of these chips.
>
> I fail to see how it matters.
>
> --
> Jean Delvare
>



-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
