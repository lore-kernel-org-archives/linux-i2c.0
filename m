From: "Amit Walambe" <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH] fix i801_transaction() and ioctl return values
	for i2c-i801
Date: Mon, 9 Jun 2008 11:56:56 +0100
Message-ID: <20080609115656.27d37dc2@eurotech-ltd.co.uk>
References: <20080606124447.756f8262@eurotech-ltd.co.uk>
	<20080608201828.18483a17@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080608201828.18483a17-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

Hi!
Over the weekend, I have investigated a bit more and the problem doesn't
appear on 2.6.23 from Fedora 8. So, this discussion holds value only if
anyone thinks the problem is a function of latencies (due to 
responsiveness of the controller and/or other factors) and can surface 
some other time. Otherwise, put a return 0 right here :). 

I still think the patch is applicable even to the latest kernels. Please 
bear with me for a bit longish reply.

On Sun, 8 Jun 2008 20:18:28 +0200
"Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Out of curiosity, why are you using this proprietary utility instead
> of the standard i2cget and i2cset programs?
> 
> > This is the relevant line from the lspci output : 
> > 00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> > SMBus Controller (rev 02)
> 
> Which kernel is your customer using? There have been a number of
> improvements done to the i2c-i801 driver over the last year. And what
> motherboard is this? Please provide the output of i2cdetect for this
> bus.
The board is a SBC named Apollo from Eurotech. Kernel is 2.6.9 from
Fedora 3. (At first, I looked through the latest kernel code to see if
I can backport any fixes, but there wasn't anything relevant to the
problem at hand.) 

i2regs is still around because 'if it works, don't change it' thing.
Also, it has 'mask' functionality which some people use. We can put
masks into standard utilities if you wish to do so.

Here is the i2cdetect output : 
#./i2cdetect -l
i2c-0   smbus           SMBus I801 adapter at 1880              SMBus
adapter

> Is there a second master on the SMBus on the customer's system?
I think you are pointing to the i801 errattum about the second host on
the same bus. There is a I2C master in ethernet device (for remote
monitoring etc.) on the same bus but it is disabled in the EPROM
itself. So it can't generate any traffic. Just to be safe about this,
we had protocol analyser running on the system and there was no other
i2c activities going on except that by the script.

> > Enabling debug in kernel produced following messages : 
> > i801_smbus 0000:00:1f.3: Failed reset at end of transaction(01)
> > i801_smbus 0000:00:1f.3: SMBus busy (01). Resetting... 
> > i801_smbus 0000:00:1f.3: Failed! (01)
> > i801_smbus 0000:00:1f.3: SMBus busy (01). Resetting... 
> > i801_smbus 0000:00:1f.3: Failed! (01)
> > i801_smbus 0000:00:1f.3: SMBus busy (02). Resetting... 
> > i801_smbus 0000:00:1f.3: Successfull!
> > The fix involved was to write a loop to wait for the final reset to
> > go through. After that, we still see following messages, but
> > atleast it is not failing over : 
> > i801_smbus 0000:00:1f.3: SMBus busy (02).Resetting... 
> > i801_smbus 0000:00:1f.3: Successfull! 
> > i801_smbus 0000:00:1f.3: SMBus busy (02). Resetting... 
> > i801_smbus 0000:00:1f.3: Successfull!
> 
> Comparing this to the log above, I don't see any change. Resetting
> when register value was 02 was already working. It's resetting when
> register value was 01 that was failing, so that's what you need to
> check with the patch applied.
I think the problem was that resetting after a transaction was taking a
bit longer and as we are doing heavy read/writes, the next request
would arrive, only to find the host controller busy.
The patch only waits till the operation finishes, so that no subsequent
transaction gets 01 (busy) error.
I guess the above log shows that the scenario is taken care by the
patch. The second condition (02 : INTR bit set : transaction complete)
is seen by the next transaction rarely and is a status message, not
failure.

> > happens because i801_transaction returns -1 for all the failures
> > and that value is taken up to the user level. So I have changed the
> > return values to suit the cause better. This is also included in
> > the same patch. 
> 
> We already have a fix pending for this problem:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-adapters-return-proper-error-codes.patch
> It will be merged in kernel 2.6.27.
I missed the boat then :)

> First of all: please note that the kernel code uses tabs for
> indentation, while your patch uses 4 spaces. You'll have to fix your
> patch.
I am aware of this. I use vi with 'set tabstop=4' and obtained patch
using 'git diff > i2c-i801.patch'. Mail client (claws-mail) couldn't
have messed it up as I used the patch as attachment (and not inline as
it is expected).
I am not sure where it went wrong, will check up. Sorry about that.

> I am very worried by the code 01 which triggers the reset (which is
> probably not the right thing to do, BTW.) The host should never be
> busy when we start a transaction. If the problem happens frequently,
I think we have a case where it is busy because the final operation
(resetting the status bits) in the last transaction didn't finish. 
I first tried to reduce reads/writes for the reset to make it "less
busy" and added a small delay, but it didn't work : 
diff --git a/drivers/i2c/busses/i2c-i801.c
b/drivers/i2c/busses/i2c-i801.c index b0f771f..0dde673 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -195,9 +195,10 @@ static int i801_transaction(int xact)
                dev_dbg(&I801_dev->dev, "Error: no response!\n");
        }
 
-       if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
-               outb_p(inb(SMBHSTSTS), SMBHSTSTS);
+       if ((temp = (inb_p(SMBHSTSTS) & 0x1f)) != 0x00)
+               outb_p(temp, SMBHSTSTS);
 
+       msleep(1);
        if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
                dev_dbg(&I801_dev->dev, "Failed reset at end of
transaction " "(%02x)\n", temp);

> this strongly suggests that some other code is making use of the host
> controller. This could for example be ACPI code. Please provide the
> DSDT for this machine (in private.)
I can assure you that there are no other transactions on the bus. We
verified using an analyser.

> If something else is making use of the SMBus host then the i2c-i801
> driver can't use it safely, no matter how you look at it. So my
> feeling is that your patch, if it does anything, is not actually
> solving the problem but only hiding it or making it less likely to
> happen.
I think I didn't provide sufficient information last time. Apologies.
Please let me know what you think now. This is the patch which I ran
over the weekend without any failures : 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b0f771f..d165829 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -198,9 +198,17 @@ static int i801_transaction(int xact)
        if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
                outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
-       if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-               dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
-                       "(%02x)\n", temp);
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

Thanks and regards

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
