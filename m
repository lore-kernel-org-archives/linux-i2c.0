From: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Wed, 04 Apr 2012 18:54:20 -0400
Message-ID: <4F7CD11C.2090801@interlog.com>
References: <20120315180835.2e669111@endymion.delvare> <20120331081927.2438ea9e@endymion.delvare>
Reply-To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120331081927.2438ea9e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 12-03-31 02:19 AM, Jean Delvare wrote:
> On Thu, 15 Mar 2012 18:08:35 +0100, Jean Delvare wrote:
>> As the bus driver side implementation of I2C_M_RECV_LEN is heavily
>> tied to SMBus, we can't support received length over 32 bytes, but
>> let's at least support that.
>>
>> In practice, the caller will have to setup a buffer large enough to
>> cover the case where received length byte has value 32, so minimum
>> 32 + 1 = 33 bytes, possibly more if there is a fixed number of bytes
>> added for the specific slave (for example a checksum.)
>>
>> Signed-off-by: Jean Delvare<khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>> Cc: Douglas Gilbert<dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
>> ---
>> This is an alternative to Doug's implementation. Doug, I sent this to
>> you one week ago, did you have the time to give it a try, do you have
>> any comment? Again I can't test this myself so someone else will have
>> to do it.
>
> Douglas, please?

Jean,
Sorry about the delay in responding. The patch didn't work
in the case of the Sonmicro SM130 RFID but I could see it was close.

The correct response (for the SM130) when reading the firmware
version is this 10 byte response:
   08 81 49 32 43 20 32 2e 38 ff     ["I2C 2.8"]
so the count in the first byte excludes itself and the checksum
trailing byte. With the I2C_M_RECV_LEN patch I see this response:
   08 81 49 32 43 20 32 2e 00 00
so the count (leading) byte includes itself and makes no
provision for a checksum. [So 8 bytes are returned and the two
trailing zeros are just buffer pre-fill.]

You might argue that the I2C_M_RECV_LEN patch is sensible
and the SM130 is strange. My solution is to read 32 bytes
which is more than I ever expect.

Doug Gilbert
