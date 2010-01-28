From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Thu, 28 Jan 2010 14:46:23 +0200
Message-ID: <af0693f01001280446u66923c70ld707d10b9fcee068@mail.gmail.com>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	 <20100128085904.4e202de1@hyperion.delvare>
	 <af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	 <20100128105340.41aecf64@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100128105340.41aecf64-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Thu, Jan 28, 2010 at 11:53 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wro=
te:
> Hi Felix,
>
> On Thu, 28 Jan 2010 11:32:28 +0200, Felix Rubinstein wrote:
>> Please explain to me how do you interpret "I2C Block Write"?
>> To my understanding it's I2C, not SMBus, transaction on the bus,
>> meaning (from Documentation/i2c/i2c-protocol)
>> S Addr Wr [A] Data [A] Data [A] ... [A] Data [A] P
>
> No, the above isn't what people commonly call "I2C block write". What
> people commonly call "I2C block write", and which would probably be
> more appropriately called "1-byte addressing I2C block write" is (as
> documented in Documentation/i2c/i2c-protocol):
>
> S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
>
> That being said, please note that the difference is only theoretical:
> nothing differentiates command bytes from data bytes on the wire.
>
>> on the other hand SMBus transaction looks like this:
>> S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] =
P
>>
>> The diff is obvious, no Count (not to say Comm) bytes in I2C
>> transaction (well, it's clear, ICH9 is SMBus, not I2C bus). But what
>> does "I2C Block Write" then means?
>
> See "I2C block write" as functionally equivalent to "SMBus block writ=
e"
> but for non-SMBus devices such as I2C EEPROMs. The goal is the same
> (write a series of bytes to the device at a given sub-address) but th=
e
> on-the-wire format is different (size goes on the wire for SMBus, not
> for I2C.)
>
> While "I2C block write" isn't part of the SMBus specification, we hav=
e
> implemented it in a similar way, simply because many SMBus controller=
s
> implement that transaction type.
>
>> > I have no idea what you mean with "I2C's multi-block". Please be
>> > specific.
>>
>> S Addr Wr [A] Data [A] Data [A] ... [A] Data [A] P
>
> OK, that's a straight I2C write of arbitrary length.
>
>> Does =A0i2c-i801.c =A0support the following kind of transactions?
>> S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
>> (note, no count byte on the bus, taken from Documentation/i2c/smbus-=
protocol)
>
> Yes, it does. Use i2c_smbus_write_i2c_block_data(). And if you don't
> need the command byte, you can abuse it by passing the first data byt=
e
> as the command.
>
>> looking at i801_block_transaction_by_block:
>>
>> =A0 =A0 =A0 =A0 if (read_write =3D=3D I2C_SMBUS_WRITE) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D data->block[0];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(len, SMBHSTDAT0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < len; i++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(data->block[i=
+1], SMBBLKDAT);
>> =A0 =A0 =A0 =A0 }
>>
>> Meaning len is put on the bus.
>
> No, the above piece of code doesn't imply this. The length is written
> to one register of the SMBus controller. It doesn't imply in any way
> that the controller will push that value on the wire. In the case of
> I2C block transactions, it does not.
How exactly the len is not pushed on the wire?
In i801_transaction, the outb_p(xact | I801_START, SMBHSTCNT);
where xact has I801_BLOCK_DATA (101b) turned on.

here is an excerpt from ICH9 datasheet:
101 =3D Block: This command uses the transmit slave address, command, D=
ATA0
registers, and the Block Data Byte register. For block write, the
count is stored
in the DATA0 register and indicates how many bytes of data will be tran=
sferred.

But DATA0 was assigned a value of len before that by means of the
above code snipet.
Please shed the light why SMBus controller will not push the len byte
on the wire if DATA0 equals to len and Block SMB_CMD (as defined in
the datasheet on page 761) equals to 101b (I801_BLOCK_DATA).


Thanks,
=46elix R.


>
> BTW, the ICH9 datasheet is public, so you can easily check what exact=
ly
> the controller does for each transaction type.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>
