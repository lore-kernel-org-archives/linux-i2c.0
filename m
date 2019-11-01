From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH resend] i2c: core: Use DEVICE_ATTR_RW() helper macros
Date: Fri, 1 Nov 2019 22:56:32 +0100
Message-ID: <9ac7a889-ca10-649e-9404-1f785645f8b8@lucaceresoli.net>
References: <20191025091950.23563-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191025091950.23563-1-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Geert,

On 25/10/19 11:19, Geert Uytterhoeven wrote:
> Convert the i2c core sysfs attributes from DEVICE_ATTR() to
> DEVICE_ATTR_RW(), to reduce boilerplate.
> This requires renaming some functions.

Nitpicking: it's DEVICE_ATTR_RO and _WO, not _RW (both here and in the
subject). I'd replace with 'DEVICE_ATTR_*()'.

With this fixed:
 Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
