From: Carsten Presser <cpresser-pU4/R+pU9Dk8A+ecXBYBpg@public.gmane.org>
Subject: i810 and fs454 problems
Date: Mon, 21 Jul 2008 21:35:52 +0200
Message-ID: <4884E518.4080000@fsing.uni-sb.de>
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

Hello,

this issue has already been reported 
(http://www.mail-archive.com/i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org/msg01197.html), but i 
managed to get some more information. using a digital oscilloscope, i 
created some pictures:
http://fsing.fs.uni-sb.de/~cpresser/tmp/smt7020/i2cset_0x6a_0xc4_0x9842_ACK_error.jpg

for me, this looks like an error at the ACK bit. the bus seems not to be 
freed, and hence, the i810 and fs454 output-drivers work against each 
other, generating a 2Volt level.

more images and data (matlab) can be found at 
http://fsing.fs.uni-sb.de/~cpresser/tmp/smt7020/

any suggestions how to fix this?

regards carsten

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
