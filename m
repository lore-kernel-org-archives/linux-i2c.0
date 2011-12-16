From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv8 3/5] OMAP: I2C: Reset support
Date: Fri, 16 Dec 2011 01:38:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160138310.12660@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> Under some error conditions the i2c driver may do a reset.
> Adding a reset field and support in the device-specific code to aid
> error-recovery.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.3.


- Paul
