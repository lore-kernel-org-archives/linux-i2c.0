From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Thu, 28 Jan 2010 11:32:28 +0200
Message-ID: <af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	 <20100128085904.4e202de1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100128085904.4e202de1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,
Thanks for clarifying things, but I still have got some misunderstandin=
gs :)
Inlined.

On Thu, Jan 28, 2010 at 9:59 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Felix,
>
> On Wed, 27 Jan 2010 19:56:02 +0200, Felix Rubinstein wrote:
>> Running i2cdetect on ICH9 says:
>> "I2C Block Write =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0yes"
>>
>> But having a closer look at how the whole thing is implemented prove=
s
>> that no i2c block write is supported.
>>
>> The proof:
>> 1. i801_probe turns i801_features to FEATURE_I2C_BLOCK_READ
>
> Yes it does, but this is totally unrelated to I2C block _writes_.
>
>> 2. as a sequence in i801_block_transaction
>> i801_block_transaction_byte_by_byte is called
>
> No. Read the code again, for the ICH9, i801_block_transaction_by_bloc=
k
> is called, not i801_block_transaction_byte_by_byte.
Pardon, I was wrong didn't pay careful attention to the fall through
in i801_probe when FEATURE_BLOCK_BUFFER is also turned on.

>
>> 3. on the other hand i801_block_transaction_byte_by_byte does
>> =A0 =A0if (read_write =3D=3D I2C_SMBUS_WRITE)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 outb_p(len, SMBHSTDAT0);
>> meaning SMBus length.
>
> This is correct, and as a matter of fact,
> i801_block_transaction_by_block does the same. And this is the right
> thing to do: the SMBus controller must know how many bytes it must se=
nd
> to the target slave.
Please explain to me how do you interpret "I2C Block Write"?
To my understanding it's I2C, not SMBus, transaction on the bus,
meaning (from Documentation/i2c/i2c-protocol)
S Addr Wr [A] Data [A] Data [A] ... [A] Data [A] P

on the other hand SMBus transaction looks like this:
S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] P

The diff is obvious, no Count (not to say Comm) bytes in I2C
transaction (well, it's clear, ICH9 is SMBus, not I2C bus). But what
does "I2C Block Write" then means?

>
>> But what if I want to write I2C's multi-block (without length or eve=
n
>> command before)?
>
> I have no idea what you mean with "I2C's multi-block". Please be
> specific.
S Addr Wr [A] Data [A] Data [A] ... [A] Data [A] P

>
>> I cannot understand why i801_func turns on I2C_FUNC_SMBUS_WRITE_I2C_=
BLOCK?
>
> Because it supports that transaction type. Why would you want it to n=
ot
> advertise a transaction type it supports?
>
Does  i2c-i801.c  support the following kind of transactions?
S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
(note, no count byte on the bus, taken from Documentation/i2c/smbus-pro=
tocol)

looking at i801_block_transaction_by_block:

        if (read_write =3D=3D I2C_SMBUS_WRITE) {
                len =3D data->block[0];
                outb_p(len, SMBHSTDAT0);
                for (i =3D 0; i < len; i++)
                        outb_p(data->block[i+1], SMBBLKDAT);
        }

Meaning len is put on the bus.

> Please refer to Documentation/i2c/smbus-protocol for what exactly eac=
h
> supported transaction type is doing at the wire level.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>
