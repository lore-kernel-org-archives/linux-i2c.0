From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 16/24] i2c: allow adapter drivers to override the
 adapter locking
Date: Tue, 3 May 2016 23:39:08 +0200
Message-ID: <20160503213908.GC2018@tetsubishi>
References: <1461165484-2314-1-git-send-email-peda@axentia.se>
 <1461165484-2314-17-git-send-email-peda@axentia.se>
 <20160428205018.GA3553@katana>
 <470abe38-ab5f-2d0a-305b-e1a3253ce5a9@axentia.se>
 <20160429071604.GB1870@katana>
 <357e6fda-73b3-fb7f-c341-97f09af1943f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <357e6fda-73b3-fb7f-c341-97f09af1943f@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Jiri Slaby <jslaby@suse.com>, Daniel Baluta <daniel.baluta@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Adriana Reus <adriana.reus@intel.com>, Matt Ranostay <matt.ranostay@intel.com>, Krzysztof Kozlowski <k.kozlo>
List-Id: linux-i2c@vger.kernel.org

> Yes, they look like reasonable complaints.

Thanks for fixing them. I just sent out my latest comments and when you
fix those and send V8, I'll apply that right away. I think we are safe
to fix the rest incrementally if needed. Note that I didn't review the
IIO and media patches, I trust the reviewers on those.

Thanks for your work on this! I need a break now, this is
mind-boggling...
