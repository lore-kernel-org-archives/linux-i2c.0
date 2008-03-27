From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] i2c: SuperH Mobile I2C Bus Controller V3
Date: Thu, 27 Mar 2008 15:07:37 -0700
Message-ID: <20080327150737.be28a398.akpm@linux-foundation.org>
References: <20080325105559.GA30232@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20080325105559.GA30232@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: i2c@lm-sensors.org, khali@linux-fr.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 25 Mar 2008 19:55:59 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> This is V3 of the SuperH Mobile I2C Controller Driver.

i386 allmodconfig:

ERROR: "clk_get_rate" [drivers/i2c/busses/i2c-sh_mobile.ko] undefined!
ERROR: "clk_get" [drivers/i2c/busses/i2c-sh_mobile.ko] undefined!
ERROR: "clk_put" [drivers/i2c/busses/i2c-sh_mobile.ko] undefined!
