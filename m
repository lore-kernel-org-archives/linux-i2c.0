From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Thu, 28 Jan 2010 14:29:41 +0100
Message-ID: <20100128142941.4daf2dfc@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128085904.4e202de1@hyperion.delvare>
	<af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	<20100128105340.41aecf64@hyperion.delvare>
	<af0693f01001280446u66923c70ld707d10b9fcee068@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01001280446u66923c70ld707d10b9fcee068-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Thu, 28 Jan 2010 14:46:23 +0200, Felix Rubinstein wrote:
> On Thu, Jan 28, 2010 at 11:53 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > No, the above piece of code doesn't imply this. The length is written
> > to one register of the SMBus controller. It doesn't imply in any way
> > that the controller will push that value on the wire. In the case of
> > I2C block transactions, it does not.
> How exactly the len is not pushed on the wire?
> In i801_transaction, the outb_p(xact | I801_START, SMBHSTCNT);
> where xact has I801_BLOCK_DATA (101b) turned on.
> 
> here is an excerpt from ICH9 datasheet:
> 101 = Block: This command uses the transmit slave address, command, DATA0
> registers, and the Block Data Byte register. For block write, the
> count is stored
> in the DATA0 register and indicates how many bytes of data will be transferred.
> 
> But DATA0 was assigned a value of len before that by means of the
> above code snipet.
> Please shed the light why SMBus controller will not push the len byte
> on the wire if DATA0 equals to len and Block SMB_CMD (as defined in
> the datasheet on page 761) equals to 101b (I801_BLOCK_DATA).

You didn't finish your homework... ;)

Straight from the ICH9 datasheet:

Note: For Block Write, if the I2C_EN bit is set, the format of the command changes slightly.
      The ICH9 will still send the number of bytes (on writes) or receive the number of bytes
      (on reads) indicated in the DATA0 register. However, it will not send the contents of the
      DATA0 register as part of the message. Also, the Block Write protocol sequence
      changes slightly: the Byte Count (bits 27:20 in the bit sequence) are not sent - as a
      result, the slave will not acknowledge (bit 28 in the sequence).

And we do set the I2C_EN bit in the i2c_smbus_write_i2c_block_data()
case:

	if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
		if (read_write == I2C_SMBUS_WRITE) {
			/* set I2C_EN bit in configuration register */
			pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
			pci_write_config_byte(I801_dev, SMBHSTCFG,
					      hostc | SMBHSTCFG_I2C_EN);
		} [...]

I hope this clarifies the situation.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
