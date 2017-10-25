From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] I2C-PIIX4: Use common error handling code in
 piix4_probe()
Date: Wed, 25 Oct 2017 16:33:47 +0200
Message-ID: <1508942027.5353.9.camel@suse.de>
References: <be36ce5f-9e75-6c05-86a2-ea8368f09dc1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be36ce5f-9e75-6c05-86a2-ea8368f09dc1@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On mer., 2017-10-25 at 13:40 +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Oct 2017 13:30:18 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I'm no longer taking patches from you.

-- 
Jean Delvare
SUSE L3 Support
