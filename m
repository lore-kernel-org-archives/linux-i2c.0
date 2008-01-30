From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Complex I2C device
Date: Wed, 30 Jan 2008 15:46:57 +0100
Message-ID: <20080130144657.GA9444@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hello,

my custom board has a =ABcomplex=BB device... let me explain better: it's
formed by a custom I2C device and an I/O extender PCA9539.

Ascii art:


                +---------+
          --+---+         |
            |   | PCA9539 |
            |   +---------+
Bus I2C ->> |      | | |
            |      | | | <<--- GPIOs
            |      | | |
            |   +---------+
            +---+         |
                |   CHIP  |
                +---------+  =


Some input GPIOs of CHIP are managed by the PCA9539. So fisically I
have two devices but logically they are merged together into one.

I can send commands to CHIP by both I2C bus and the GPIOs, which in
turn are controlled by the PCA9539.

Can you please suggest me the best way to manage this problem? My
solution was to provide PCA9539's driver of some exported symbols and
using them into the CHIP's driver. Is that right? Or, can I "call" (in
any way) PCA9539 driver's methods from CHIP's driver?

Thanks,

Rodolfo

-- =


GNU/Linux Solutions                  e-mail:    giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                             giometti-kaDoWcXyVrEAvxtiuMwx3w@public.gmane.org
Embedded Systems                     		giometti-k2GhghHVRtY@public.gmane.org
UNIX programming                     phone:     +39 349 2432127

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
