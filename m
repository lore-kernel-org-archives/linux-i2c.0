From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v3 3/3] i2c: smbus: switch from loops to memcpy
Date: Wed, 13 Nov 2019 10:47:55 +0100
Message-ID: <320567eb-00f5-2228-c507-317131b4af74@lucaceresoli.net>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
 <20191112203132.163306-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112203132.163306-4-dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-iio@vger.kernel.orgi, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Dmitry,

On 12/11/19 21:31, Dmitry Torokhov wrote:
> When copying memory from one buffer to another, instead of open-coding
> loops with byte-by-byte copies let's use memcpy() which might be a bit
> faster and makes intent more clear.

Good idea!

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
