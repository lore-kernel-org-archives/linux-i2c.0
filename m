From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] [RFC] i2c: Don't wait for device release in i2c_del_adapter
Date: Wed, 14 Jan 2015 06:14:52 -0800
Message-ID: <54B679DC.40303@roeck-us.net>
References: <1421082050-10213-1-git-send-email-pantelis.antoniou@konsulko.com> <20150113152957.GL7660@katana> <20150114144938.4e3c3f52@endymion.delvare> <B2D57D11-FBC2-432A-90E8-90E4CF8F716C@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B2D57D11-FBC2-432A-90E8-90E4CF8F716C-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/14/2015 05:54 AM, Pantelis Antoniou wrote:

>> That being said, nobody complained about this in 11 years, so I would
>> be surprised if it was plain wrong. I'd rather question the test code.
>> Where is it?
>>
>
> No-one has apparently tested removing an i2c mux device on a running system
> before.
>
Hi Pantelis,

We didn't see the problem with 3.14. That was with an earlier version of the
overlay patchset, though.

Guenter
