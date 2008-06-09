From: "Amit Walambe" <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH] fix i801_transaction() and ioctl return values
	for i2c-i801
Date: Mon, 9 Jun 2008 14:25:49 +0100
Message-ID: <20080609142549.5a61edfd@eurotech-ltd.co.uk>
References: <20080606124447.756f8262@eurotech-ltd.co.uk><20080608201828.18483a17@hyperion.delvare><20080609115656.27d37dc2@eurotech-ltd.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080609115656.27d37dc2-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Correcting an initialisation error..
On Mon, 9 Jun 2008 11:56:56 +0100
Amit Walambe <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org> wrote:

> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index b0f771f..d165829 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -198,9 +198,17 @@ static int i801_transaction(int xact)
>         if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
>                 outb_p(inb(SMBHSTSTS), SMBHSTSTS);
>  
> -       if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
> -               dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
> -                       "(%02x)\n", temp);
> +       /* We wait for a fraction of a second! */
> +       do {
> +               msleep(1);
> +               temp = inb_p(SMBHSTSTS);
> +       } while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
> +
> +       /* If the SMBus is still busy, we give up */
> +       if (timeout >= MAX_TIMEOUT) {
> +               result = -EBUSY;
> +               dev_dbg(&I801_dev->dev, "Failed reset at end of transaction"
> +                               "(%02x)\n", temp);
>         }
>         dev_dbg(&I801_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
>                 "ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
> 
> Thanks and regards
> 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b0f771f..f6b4598 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -198,9 +198,18 @@ static int i801_transaction(int xact)
        if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
                outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
-       if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-               dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
-                       "(%02x)\n", temp);
+       timeout = 0;
+       /* We wait for a fraction of a second! */
+       do {
+               msleep(1);
+               temp = inb_p(SMBHSTSTS);
+       } while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
+
+       /* If the SMBus is still busy, we give up */
+       if (timeout >= MAX_TIMEOUT) {
+               result = -EBUSY;
+               dev_dbg(&I801_dev->dev, "Failed reset at end of transaction"
+                               "(%02x)\n", temp);
        }
        dev_dbg(&I801_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
                "ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),

-- 
Amit Walambe
Design Engineer

Eurotech Ltd,
3 Clifton Court,
Cambridge CB1 7BN,
United Kingdom.

Tel: +44 (0)1223 403465 Direct
Tel: +44 (0)1223 411200 Switchboard
Fax: +44 (0)1223 410457
E-Mail: amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org
Web: http://www.eurotech-ltd.co.uk

Eurotech Ltd is a subsidiary of Eurotech S.p.A
VAT No. GB 314961067    Registered in England 1608562
Registered Office: 3 Clifton Court, Clifton Road, Cambridge CB1 7BN  UK

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
