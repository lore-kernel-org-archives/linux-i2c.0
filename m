From: "eric miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Thu, 10 Jul 2008 21:48:16 +0800
Message-ID: <f17812d70807100648m13896650xdafab02b5dc448ec@mail.gmail.com>
References: <486B9E30.80806@cam.ac.uk> <20080710133150.GH30539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080710133150.GH30539-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
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
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 10, 2008 at 9:31 PM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> On Wed, Jul 02, 2008 at 04:26:40PM +0100, Jonathan Cameron wrote:
>> Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
>> appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
>> than frequency as this driver is also used for the i2c_pxa_pwr bus which has
>> different normal and fast frequencies.
>>
>> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
>
> Unfortuantely due to the problem of all the registers in
> one place, this really will need to be applied by RMK. However
> due to the current amount of work in the PXA tree, and the
> number of patches he is carrying for merging this is going
> to be too late for this kernel merge.
>

Actually, this round of separation work of the pxa-regs.h has been
done several weeks ago, so I don't see this patch is likely to
cause any merge conflict.

But Russell is going to freeze the pxa branch, I see little chance
this be fixed quickly and get into :(

-- 
Cheers
- eric

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
