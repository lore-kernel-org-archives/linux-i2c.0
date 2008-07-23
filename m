From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/03] i2c-i801: Add basic interrupt support
Date: Wed, 23 Jul 2008 18:56:00 +0200
Message-ID: <488762A0.8030409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey All,

It's been a while since I last posted about this matter, but the patch =

is finally there.

This patch adds basic interrupt support to the i2c-i801 bus driver. This =

means i2c transactions can be completed without useless and pricy =

waiting loops (the polling) and speeds things up.
Currently only basic transactions are support. The HW PEC or i2c block =

transactions still use polling.

To write this patch, I've extensively used Mark M. Hoffman's i2c-i801 =

rewrite of the i2c-i801 driver dating back from 28 Nov 2008. This can be =

found at http://archives.andrew.net.au/lm-sensors/msg28496.html

I've tested this patch extensively on a machine provided by the Hague =

University (Thanks Hans! ;) which is ICH5 based, but it needs a lot of =

more testing. So please be welcome to give the patch a shot.

Since I=92m completely new to linux device driver development, interrupts =

and i2c, stupid mistakes can be very well possible. Please use this =

patch with caution and let me know whatever I did wrong :). Oh, and if =

your PC won=92t start up anymore, removing power from the PC always worked =

for me ;p.

All patches are made against 2.6.26-rc9

Patch 1 implements the functionality, while patch 2 only adds the =

alignment changes. This is done to make it easier reviewable. Patch 3 is =

quite unrelated and only fixes some checkPatch warnings..

---
Ivo Manca

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
