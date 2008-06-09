From: Amit Walambe <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
Subject: Re:
	=?utf-8?q?=5BPATCH=5D_fix_i801=5Ftransaction=28=29_and_ioct?=
	=?utf-8?q?l_return_values_for_i2c-i801?=
Date: Mon, 9 Jun 2008 15:27:50 +0000 (UTC)
Message-ID: <loom.20080609T150250-626@post.gmane.org>
References: <20080606124447.756f8262@eurotech-ltd.co.uk>
	<20080608201828.18483a17@hyperion.delvare>
	<20080609115656.27d37dc2@eurotech-ltd.co.uk>
	<20080609152352.40f3b5eb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare <khali@...> writes:

> 
> Hi Amit,
Hi Jean!
I didn't receive this reply in my inbox. Otherwise I wouldn't have sent my
corrected patch. Sorry about that.

> I don't understand. You just said yourself that the problem didn't show
> on a 2.6.23 kernel, meaning that we somehow fixed the bug already, but
> still you want your patch to be applied?
My patch only waits till the busy bit clears. As you have said in your reply, it
adds unconditional delay of atleast 1 ms, but it avoided a few subsequent user
requests from failing.
I agree this happened on a very old kernel with vastly different behaviour, but
there is nothing in the current code to prevent it from happening. Still, I make
it your call if too cautious (but slow) patch is a good idea or not.
Please let me know if you think.

> For example, this patch:
>
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ca8b9e32a11a7cbfecbef00c8451a79fe1af392e
> seems pretty relevant to me, as it attempts to cleanly stop the
> controller on transaction timeout. It went into kernel 2.6.23.
This patch is useful to handle the failure that has occured (a new request fails
since controller is still busy with previous operation). But it doesn't avoid
this situation.

> i2cset supports this functionality since October 2004.
Apologies.

> I asked for the output of i2cdetect (i2cdetect 0 in your case), not
> i2cdetect -l. I wanted to have an idea what chips were present on the
> bus.
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: 20 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: 30 -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- 44 -- -- -- 48 -- -- -- -- -- -- -- 
50: 50 -- -- -- 54 -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- 69 6a -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         

> Please note that "resetting" is not really the correct term for what
I used the "resetting the status bits" at some other places in the my email.
Shouldn't have used it interchangebly.

> One important thing to notice is that the driver is still doing
> something wrong in this area. If the host is found busy (bit 0 of the
> status register) the driver attempts to write 1 to that bit. Given that
> the bit in question is read-only, I'd say the chances that it works are
> thin... 
Ok, so the bit manipulation part is useless and wait part is only relevant.

> One thing that might still be worth investigating is why some
> transactions do not complete in the first place.
> 
> This might be related to the fact that the timeout loop was written
> with HZ=100 in mind and is broken by design. It timeouts in count (100,
> where all but one drivers have 500), not time. Depending on various
> parameters (amongst which the value of HZ), the actual time it waits
> for is very different. At HZ=100 it was typically 2 seconds, but at
> HZ=1000 it would be 200 ms, which isn't that much. Although at 16 kHz,
> a 32-byte I2C block read transaction would take 20 ms if I count
> correctly, so it still fits.
> 
> Could it be that some slave on the customer's I2C bus is misbehaving
> and holding the clock line low for longer than it should?
I will investigate more on this line. 

Thanks a lot for your help. 
- Amit


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
