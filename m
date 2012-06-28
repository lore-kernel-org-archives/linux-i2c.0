From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 4/8 v3] i2c: i801: check and return errors during
 byte-by-byte transfers
Date: Thu, 28 Jun 2012 11:46:28 +0800
Message-ID: <CAGS+omDkhA=dP0JP=4huQEwJ4j6YqZWJ+mFsJv+eeGMBRpu5fQ@mail.gmail.com>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
 <1340805255-8041-5-git-send-email-djkurtz@chromium.org> <20120627185136.315e6625@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120627185136.315e6625@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Seth Heasley <seth.heasley@intel.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 28, 2012 at 12:51 AM, Jean Delvare <khali@linux-fr.org> wro=
te:
> On Wed, 27 Jun 2012 21:54:11 +0800, Daniel Kurtz wrote:
>> If an error is detected in the polling loop, abort the transaction a=
nd
>> return an error code.
>>
>> =A0* DEV_ERR is set if the device does not respond with an acknowled=
ge, and
>> the SMBus controller times out (minimum 25ms).
>> =A0* BUS_ERR is set if a bus arbitration collision is detected. =A0I=
n other
>> words, when the SMBus controller tries to generate a START condition=
, but
>> detects that the SMBDATA is being held low, usually by another SMBus=
/I2C
>> master.
>> =A0* FAILED is only set if a the transaction is set by software (usi=
ng the
>> SMBHSTCNT KILL bit).

That was supposed to say:

 * FAILED is only set if a transaction is stopped by software (using
the SMBHSTCNT KILL bit).

> Not quite sure what you mean with "set by software". Other than this,
> patch looks good, applied, thanks.

Applied where?
I'd like to send a rebased patchset onto whatever you have already stag=
ed.

>
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>> =A0drivers/i2c/busses/i2c-i801.c | =A0 10 ++++++----
>> =A01 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-=
i801.c
>> index 6a53338..ba56b74 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -131,9 +131,11 @@
>> =A0#define SMBHSTSTS_INTR =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>> =A0#define SMBHSTSTS_HOST_BUSY =A00x01
>>
>> -#define STATUS_FLAGS =A0 =A0 =A0 =A0 (SMBHSTSTS_BYTE_DONE | SMBHSTS=
TS_FAILED | \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SMBHSTS=
TS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SMBHSTS=
TS_INTR)
>> +#define STATUS_ERROR_FLAGS =A0 (SMBHSTSTS_FAILED | SMBHSTSTS_BUS_ER=
R | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SMBHSTS=
TS_DEV_ERR)
>> +
>> +#define STATUS_FLAGS =A0 =A0 =A0 =A0 (SMBHSTSTS_BYTE_DONE | SMBHSTS=
TS_INTR | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0STATUS_=
ERROR_FLAGS)
>>
>> =A0/* Older devices have their ID defined in <linux/pci_ids.h> */
>> =A0#define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS =A0 =A0 =A0 =A00x1c=
22
>> @@ -385,7 +387,7 @@ static int i801_block_transaction_byte_by_byte(s=
truct i801_priv *priv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(250, 500);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D inb_p(SMBHSTS=
TS(priv));
>> - =A0 =A0 =A0 =A0 =A0 =A0 } while ((!(status & SMBHSTSTS_BYTE_DONE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 } while (!(status & (SMBHSTSTS_BYTE_DONE |=
 STATUS_ERROR_FLAGS))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& (timeout++ < MAX_R=
ETRIES));
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D i801_check_post(priv, status,=
 timeout > MAX_RETRIES);
>
>
> --
> Jean Delvare
