From: ROASCIO Paolo <roa-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: PCA954x I2C switch/multiplexer
Date: Sat, 23 Feb 2008 17:07:01 +0100
Message-ID: <200802231707.01967.roa@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello, i'm new in this list, then please excuse me for my bad english...

I read the Frank's message dated jan 31 2008 about a patch for the PCA954x i2c 
mux family support.

I patched my kernel (2.6.22) without problems, bu when i load the module 
i2c_pca954x, nothing happens....

If i turn on all the kernel i2c debug related options, in dmesg i can see 
something like:

[pca9540] registered,

but, when i launch sensors-detect, i can't see any bus other than my 
i2c-amd-756.

I'm not a programmer, but reading the code, i can see that this module hasn't 
load parameters (the same result as modinfo), then, please Frank, can you 
explain me how to make the pca954x support start?

I'm a GIGABYTE GA-7DPXDW owner, where a PCA9540 "shares" two LM-90 on the sam 
i2c bus (one for each cpu), then i will be happy to test your patch if right 
pointed.

Thanks.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
