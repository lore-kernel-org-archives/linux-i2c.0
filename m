From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in i2c_del_adapter
Date: Wed, 14 Jan 2015 15:06:22 +0100
Message-ID: <54B677DE.6030204@gmx.de>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113152957.GL7660@katana> <20150114144938.4e3c3f52@endymion.delvare> <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B2D57D11-FBC2-432A-90E8-90E4CF8F716C-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am 14.01.2015 um 14:54 schrieb Pantelis Antoniou:
> Hi Jean,
>
>> On Jan 14, 2015, at 15:49 , Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
...
>> That being said, nobody complained about this in 11 years, so I would
>> be surprised if it was plain wrong. I'd rather question the test code.
>> Where is it?
>>
>
> No-one has apparently tested removing an i2c mux device on a running system
> before.

We do it day by day and it works perfectly with pca954x from 2.6.32 to 
3.14.27
So if there are problems they must have been invented lately.
-- 
JM2C
KR
Michael
