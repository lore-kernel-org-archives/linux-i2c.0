From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] fix i801_transaction() and ioctl return values
 for i2c-i801
Date: Mon, 9 Jun 2008 15:23:52 +0200
Message-ID: <20080609152352.40f3b5eb@hyperion.delvare>
References: <20080606124447.756f8262@eurotech-ltd.co.uk>
	<20080608201828.18483a17@hyperion.delvare>
	<20080609115656.27d37dc2@eurotech-ltd.co.uk>
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
To: Amit Walambe <amit.walambe-ymFC7zkAqBLaL3YF3Y4TSbVCufUGDwFn@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Amit,

On Mon, 9 Jun 2008 11:56:56 +0100, Amit Walambe wrote:
> Over the weekend, I have investigated a bit more and the problem doesn't
> appear on 2.6.23 from Fedora 8. So, this discussion holds value only if
> anyone thinks the problem is a function of latencies (due to 
> responsiveness of the controller and/or other factors) and can surface 
> some other time. Otherwise, put a return 0 right here :). 
> 
> I still think the patch is applicable even to the latest kernels. Please 
> bear with me for a bit longish reply.

I don't understand. You just said yourself that the problem didn't show
on a 2.6.23 kernel, meaning that we somehow fixed the bug already, but
still you want your patch to be applied?

> On Sun, 8 Jun 2008 20:18:28 +0200
> "Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Out of curiosity, why are you using this proprietary utility instead
> > of the standard i2cget and i2cset programs?
> > 
> > > This is the relevant line from the lspci output : 
> > > 00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> > > SMBus Controller (rev 02)
> > 
> > Which kernel is your customer using? There have been a number of
> > improvements done to the i2c-i801 driver over the last year. And what
> > motherboard is this? Please provide the output of i2cdetect for this
> > bus.
> The board is a SBC named Apollo from Eurotech. Kernel is 2.6.9 from
> Fedora 3. (At first, I looked through the latest kernel code to see if
> I can backport any fixes, but there wasn't anything relevant to the
> problem at hand.)

2.6.9 is very old. There have been so many changes made to the i2c-i801
driver since then that it's quite difficult to make sure there's no
relevant change, unless you're intimate with this driver and device.
For example, this patch:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ca8b9e32a11a7cbfecbef00c8451a79fe1af392e
seems pretty relevant to me, as it attempts to cleanly stop the
controller on transaction timeout. It went into kernel 2.6.23.

> i2regs is still around because 'if it works, don't change it' thing.
> Also, it has 'mask' functionality which some people use. We can put
> masks into standard utilities if you wish to do so.

i2cset supports this functionality since October 2004.

> Here is the i2cdetect output : 
> #./i2cdetect -l
> i2c-0   smbus           SMBus I801 adapter at 1880              SMBus adapter

I asked for the output of i2cdetect (i2cdetect 0 in your case), not
i2cdetect -l. I wanted to have an idea what chips were present on the
bus.

> > > Enabling debug in kernel produced following messages : 
> > > i801_smbus 0000:00:1f.3: Failed reset at end of transaction(01)
> > > i801_smbus 0000:00:1f.3: SMBus busy (01). Resetting... 
> > > i801_smbus 0000:00:1f.3: Failed! (01)
> > > i801_smbus 0000:00:1f.3: SMBus busy (01). Resetting... 
> > > i801_smbus 0000:00:1f.3: Failed! (01)
> > > i801_smbus 0000:00:1f.3: SMBus busy (02). Resetting... 
> > > i801_smbus 0000:00:1f.3: Successfull!
> > > The fix involved was to write a loop to wait for the final reset to
> > > go through. After that, we still see following messages, but
> > > atleast it is not failing over : 
> > > i801_smbus 0000:00:1f.3: SMBus busy (02).Resetting... 
> > > i801_smbus 0000:00:1f.3: Successfull! 
> > > i801_smbus 0000:00:1f.3: SMBus busy (02). Resetting... 
> > > i801_smbus 0000:00:1f.3: Successfull!
> > 
> > Comparing this to the log above, I don't see any change. Resetting
> > when register value was 02 was already working. It's resetting when
> > register value was 01 that was failing, so that's what you need to
> > check with the patch applied.
>
> I think the problem was that resetting after a transaction was taking a
> bit longer and as we are doing heavy read/writes, the next request
> would arrive, only to find the host controller busy.

Please note that "resetting" is not really the correct term for what
the driver is doing. We should fix this debug message to avoid the
confusion. The driver is merely clearing status bits, it's not actually
resetting anything. At least it wasn't in 2.6.9. Since 2.6.23 it kills
the stuck transactions, which is kind of a reset, but that's a
different piece of code than the part you wanted to modify.

One important thing to notice is that the driver is still doing
something wrong in this area. If the host is found busy (bit 0 of the
status register) the driver attempts to write 1 to that bit. Given that
the bit in question is read-only, I'd say the chances that it works are
thin... If the host is busy then this strongly suggests that somebody
else is using it and we should abort immediately.

> The patch only waits till the operation finishes, so that no subsequent
> transaction gets 01 (busy) error.

As written above, 01 can't be cleared by the driver with the code in
2.6.9. So your patch is waiting for the bit to clear (which makes some
sense) but the "reset" operation is not responsible for this. The bit
would have cleared itself after some time anyway. The "reset" operation
as it exists in 2.6.9 is merely a bit clearing operation, as I wrote
above, and this doesn't take time to complete. If the next check shows
that any cleared status bit is up (other than 01), it's rather "up
again" than "still up", I think.

> I guess the above log shows that the scenario is taken care by the
> patch. The second condition (02 : INTR bit set : transaction complete)
> is seen by the next transaction rarely and is a status message, not
> failure.

Ah, OK, I get the idea now.

> > I am very worried by the code 01 which triggers the reset (which is
> > probably not the right thing to do, BTW.) The host should never be
> > busy when we start a transaction. If the problem happens frequently,
>
> I think we have a case where it is busy because the final operation
> (resetting the status bits) in the last transaction didn't finish. 

Then I believe that Oleg Ryjkov's patch (URL above) is the proper fix
for your problem.

> I first tried to reduce reads/writes for the reset to make it "less
> busy" and added a small delay, but it didn't work : 
> diff --git a/drivers/i2c/busses/i2c-i801.c
> b/drivers/i2c/busses/i2c-i801.c index b0f771f..0dde673 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -195,9 +195,10 @@ static int i801_transaction(int xact)
>                 dev_dbg(&I801_dev->dev, "Error: no response!\n");
>         }
>  
> -       if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
> -               outb_p(inb(SMBHSTSTS), SMBHSTSTS);
> +       if ((temp = (inb_p(SMBHSTSTS) & 0x1f)) != 0x00)
> +               outb_p(temp, SMBHSTSTS);
>  
> +       msleep(1);
>         if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
>                 dev_dbg(&I801_dev->dev, "Failed reset at end of transaction "
>                         "(%02x)\n", temp);
> 
> > this strongly suggests that some other code is making use of the host
> > controller. This could for example be ACPI code. Please provide the
> > DSDT for this machine (in private.)
>
> I can assure you that there are no other transactions on the bus. We
> verified using an analyser.

OK, good thing. Then indeed the reason would be improperly terminated
transactions affecting the next transaction, as you suggested.

> Please let me know what you think now. This is the patch which I ran
> over the weekend without any failures : 
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

As written above, I think your problem is already fixed in 2.6.23 so no
patch is needed. I wouldn't want your patch as is anyway, as it adds a
sleep unconditionally, making the driver twice as slow as the original
code.

One thing that might still be worth investigating is why some
transactions do not complete in the first place.

This might be related to the fact that the timeout loop was written
with HZ=100 in mind and is broken by design. It timeouts in count (100,
where all but one drivers have 500), not time. Depending on various
parameters (amongst which the value of HZ), the actual time it waits
for is very different. At HZ=100 it was typically 2 seconds, but at
HZ=1000 it would be 200 ms, which isn't that much. Although at 16 kHz,
a 32-byte I2C block read transaction would take 20 ms if I count
correctly, so it still fits.

Could it be that some slave on the customer's I2C bus is misbehaving
and holding the clock line low for longer than it should?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
