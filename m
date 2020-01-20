From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 03/26] docs: i2c: summary: rewrite the "terminology"
 section
Date: Mon, 20 Jan 2020 11:04:26 +0100
Message-ID: <20200120110426.56490833@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-3-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-3-luca@lucaceresoli.net>
Sender: linux-doc-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun,  5 Jan 2020 23:49:49 +0100, Luca Ceresoli wrote:
> This section, partly dating back to the pre-git era, is somewhat
> unclear and partly incorrect. Rewrite it almost completely including a
> reference figure, concise but precise definition of each term and the
> paths where drivers are found. Particular care has been put in clarifying
> the relation between adapter and algorithm, which has no correspondence
> in the I2C spec terminology.

It may make sense to mention path "drivers/i2c/algos/" in the paragraph
which mentions reusable algorithms.

> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/i2c.svg     | 1341 +++++++++++++++++++++++++++++++++
>  Documentation/i2c/summary.rst |   35 +-
>  2 files changed, 1362 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/i2c/i2c.svg
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
