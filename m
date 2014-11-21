From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [2/5] i2c: davinci: query STP always when NACK is received
Date: Fri, 21 Nov 2014 14:48:57 +0200
Message-ID: <546F34B9.1000206@ti.com>
References: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com> <20141120221953.GI27002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141120221953.GI27002-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On 11/21/2014 12:19 AM, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 20, 2014 at 12:03:05PM +0200, Grygorii Strashko wrote:
>> According to I2C specification the NACK should be handled as folowin=
g:
> s/folowing/follows/
>=20
>> "When SDA remains HIGH during this ninth clock pulse, this is define=
d as the Not
>> Acknowledge signal. The master can then gene rate either a STOP cond=
ition to
> s/gene rate/generate/
>=20
>> abort the transfer, or a repeated START condition to start a new tra=
nsfer."
>> [http://www.nxp.com/documents/user_manual/UM10204.pdf]
> The link is nice, but pointing out that this is the i2c spec would be
> nice.
>=20
>> The same is recomened by TI I2C wiki:
> s/recomened/recommended/
>=20
>>   http://processors.wiki.ti.com/index.php/I2C_Tips
> If the specification tells what to do, there is no need to further
> support your claim.
>=20
>> Currently, the Davinci I2C driver interrupts I2C trunsfer in case of=
 NACK, but
> s/trunsfer/transfer/
>=20
>> It queries Stop condition DAVINCI_I2C_MDR_REG.STP=3D1 only if NACK h=
as been received
> s/It/it/
>=20
>> during the last message transmitting/recieving.
> s/transmitting/transmitted/; s/recieving/received/
>=20
> I think I don't understand this sentence even with the typos correcte=
d.
> Do you want to say:
>=20
> Currently the Davinci i2c driver interrupts the transfer on receipt o=
f a
> NACK but fails to send a STOP in some situations and so makes the bus
> stuck.
>=20
>> This may lead to Bus stuck in "Bus Busy" until I2C IP reset (idle/en=
able) if
>> during SMBus reading transaction the first I2C message is NACKed.
> Did you hit this problem, or is this a theoretical issue?

I've hit this issue on OMAP board and the Davinci I2C driver is impleme=
nted in a similar way.
Now I've no HW which would allow me to reproduce it on Davinci.
quotes from https://lkml.org/lkml/2013/7/16/235:
>>>
The problem is, that lm75 device is SmBus compatible and its driver has
=2Edetect() function implemented. During detection it tries to scan som=
e
registers which might be not present in current device - in my case
it's tmp105.

=46or example to read regA in tmp105 following is done:
1) do write in "Index" register (val RegA index) (I2C 1st message)
2) do read (I2C 2d message)
the message 1 is Nacked by lm75 type of device in case if register inde=
x is wrong,=20
but i2c-omap don't send NACK (or STP). As result, bus stack in Bus Busy=
=20
state.

=46or SMBus devices the specification states (http://smbus.org/specs/)
"4.2.Acknowledge (ACK) and not acknowledge (NACK)":
- "The slave device detects an invalid command or invalid data. In this
case the slave device must not acknowledge the received byte. The
master upon detection of this condition must generate a STOP condition
and retry the transaction"
<<<

>=20
> Assuming this is a candidate for stable, adding a Fixes:-footer would=
 be
> nice.
>=20
>> Hence, fix it by querying Stop condition (STP) always when NACK is r=
eceived.
>>
>> This patch fixes Davinci I2C in the same way it was done for OMAP I2=
C
>> commit cda2109a26eb ("i2c: omap: query STP always when NACK is recei=
ved").
>>
>> More info can be found at:
>> https://lkml.org/lkml/2013/7/16/159
>> http://patchwork.ozlabs.org/patch/249790/
> I'd drop this "more info" paragraph.
>=20
>> CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
>> Reported-by: Hein Tibosch <hein_tibosch-mRCrAkd8dF0@public.gmane.org>
> Is this Reported-by tag reused from the omap issue?
>=20
>> Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-davinci.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i=
2c-davinci.c
>> index 9bbfb8f..2cef115 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -411,11 +411,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, =
struct i2c_msg *msg, int stop)
>>   	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
>>   		if (msg->flags & I2C_M_IGNORE_NAK)
>>   			return msg->len;
>> -		if (stop) {
>> -			w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> -			w |=3D DAVINCI_I2C_MDR_STP;
>> -			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>> -		}
>> +		w =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
>> +		w |=3D DAVINCI_I2C_MDR_STP;
>> +		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
> I think this is a good change, but I wonder if the handling of
> I2C_M_IGNORE_NAK is correct here. If the controller reports a NACK sa=
y
> for the 2nd byte of a 5-byte-message, the transfer supposed to
> continue, right? (Hmm, maybe the framework handle this and restarts t=
he
> transfer with I2C_M_NOSTART but the davinci driver doesn't seem to
> handle this flag?)

Have nothing to say about handling of I2C_M_IGNORE_NAK. I'm not going t=
o
change current behavior - davinci driver will interrupt transfer of i2c=
_msg always
 in case of NACK and start transfer of the next i2c_msg (if exist).
In my opinion, Above question is out of scope of this patch.

Thanks for your comments.

Regards,
-grygorii
