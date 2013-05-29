From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [I2C] informations + advice about messages handling
Date: Wed, 29 May 2013 12:17:58 +0200
Message-ID: <CA78C307B8F06747967D122FC656B15398645D@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153986448@SERVEUR0.nvp.local>
	<CAK7N6vpg6QUAKODKO2Msr4+GTASLDpA2cG1teQV3yiwt7D4SSw@mail.gmail.com>
	<20130524094407.61d0ec42@endymion.delvare>
	<CA78C307B8F06747967D122FC656B15398644A@SERVEUR0.nvp.local>
	<20130524110706.6052493e@endymion.delvare>
	<CA78C307B8F06747967D122FC656B15398644B@SERVEUR0.nvp.local>
	<20130524142017.52545a52@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
Content-class: urn:content-classes:message
In-Reply-To: <20130524142017.52545a52@endymion.delvare>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kernelnewbies <kernelnewbies@kernelnewbies.org>, anish singh <anish198519851985@gmail.com>, linux-kernel-mail <linux-kernel@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Le 24/05/2013 14:20, Jean Delvare a =E9crit :
> On Fri, 24 May 2013 11:52:54 +0200, Mylene Josserand wrote:
>> - an audio codec tlv320aic3204 : There is a driver for this device but
>> for some reasons, we did not use it. Did not find a "SMBus compliant" in
>> its datasheet.
>
> The tlv320aic32x4 driver uses i2c_master_send, which is a shortcut to
> i2c_transfer. However it seems to only send 2 bytes on the bus at once,
> the same could be achieved with i2c_smbus_write_byte_data if needed.

Okay, thanks to have looked at it !

>
> For completeness: a device might use transactions which are compliant
> with SMBus without being formally "SMBus-compliant", because SMBus has
> more constraints than just transaction types (I kept things simple
> originally to not confuse you.) This may explain why it isn't mentioned
> in the datasheet. Or just because the manufacturer did not care because
> they target fully I2C-capable systems anyway.
>
> What you have to look at is the transaction types. They are usually
> described in the datasheet. Then compare with either the SMBus
> specification or
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docum=
entation/i2c/smbus-protocol
> and if they match then you can use the i2c_smbus_*() calls.


I have checked the PIC18F24201 according to your advice and, of what I =

have seen, it can handle the SMBus protocol.

Thank you for the explanation and trying to keep it simple for me :)


-- =

Myl=E8ne JOSSERAND
