From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 3/8 v3] i2c: i801: check INTR after every transaction
Date: Thu, 28 Jun 2012 15:51:34 +0800
Message-ID: <CAGS+omCoto4djKuZUooeD2A-szjrH4e9=YJCptR_raOdQ8g3-A@mail.gmail.com>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
 <1340805255-8041-4-git-send-email-djkurtz@chromium.org> <20120627180724.762f854a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120627180724.762f854a@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Seth Heasley <seth.heasley@intel.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 28, 2012 at 12:07 AM, Jean Delvare <khali@linux-fr.org> wro=
te:
> On Wed, 27 Jun 2012 21:54:10 +0800, Daniel Kurtz wrote:
>> Per ICH10 datasheet [1] pg. 711, after completing a block transactio=
n,
>> INTR should be checked & cleared separately, only after BYTE_DONE is
>> first cleared:
>>
>> =A0 When the last byte of a block message is received, the host cont=
roller
>> sets DS. However, it does not set the INTR bit (and generate another
>> interrupt) until DS is cleared. Thus, for a block message of n bytes=
,
>> the ICH10 will generate n+1 interrupts.
>>
>> [1] http://www.intel.com/content/dam/doc/datasheet/io-controller-hub=
-10-family-datasheet.pdf
>>
>> Currently, the INTR bit was only checked & cleared separately if the=
 PEC
>> was used.
>> This patch checks and clears INTR at the very end of every successfu=
l
>> transaction, regardless of whether the PEC is used.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>> =A0drivers/i2c/busses/i2c-i801.c | =A0 46 ++++++++++++++++++++------=
--------------
>> =A01 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-=
i801.c
>> index 8b74e1e..6a53338 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -257,6 +257,24 @@ static int i801_check_post(struct i801_priv *pr=
iv, int status, int timeout)
>> =A0 =A0 =A0 return result;
>> =A0}
>>
>> +/* wait for INTR bit as advised by Intel */
>> +static void i801_wait_intr(struct i801_priv *priv)
>> +{
>> + =A0 =A0 int timeout =3D 0;
>> + =A0 =A0 int status;
>> +
>> + =A0 =A0 status =3D inb_p(SMBHSTSTS(priv));
>> + =A0 =A0 while ((!(status & SMBHSTSTS_INTR)) && (timeout++ < MAX_RE=
TRIES)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(250, 500);
>> + =A0 =A0 =A0 =A0 =A0 =A0 status =3D inb_p(SMBHSTSTS(priv));
>> + =A0 =A0 }
>
> Per my comment on previous patch, I've swapped the logic here to be i=
n
> line with what we had before. I have no objection to trying this chan=
ge
> again, but later, and only if you have actual numbers to back it up.
>
>> +
>> + =A0 =A0 if (timeout > MAX_RETRIES)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&priv->pci_dev->dev, "INTR Timeout=
!\n");
>> +
>> + =A0 =A0 outb_p(status, SMBHSTSTS(priv));
>
> Wouldn't it be more correct to only write the INTR bit? Writing back
> the whole 8 bits frightens me a little especially because of bit
> INUSE_STS. If we ever want to support this feature, I think we have t=
o
> first ban writing back the whole status to register HST_STS. And this
> is the only place where we still do AFAICS.

It looks like the current code does it this way to clear any error
bits that may be set in the timeout case (errors set, but no INTR).
=46or example, if there was a bus / arbitration error while waiting for
PEC.

Perhaps we can split the difference (I tested this and it has no
obvious regression):

+     /* Clear INTR, or in case of timeout, any other status bits. */
+ =A0 =A0 outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));

But in a separate patch...

>
> (This isn't a regression from your patch, the old code was already
> doing that, but it might be the opportunity to fix it.)
>
> --
> Jean Delvare
