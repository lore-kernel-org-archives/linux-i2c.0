From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 08/26] docs: i2c: i2c-protocol: properly name start and
 stop conditions
Date: Mon, 20 Jan 2020 13:49:08 +0100
Message-ID: <20200120134908.24e728e5@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-8-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200105225012.11701-8-luca@lucaceresoli.net>
Sender: linux-doc-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun,  5 Jan 2020 23:49:54 +0100, Luca Ceresoli wrote:
> In I2C there is no such thing as a "start bit" or a "stop bit". Use the
> proper naming: "start condition" and "stop condition".
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  Documentation/i2c/i2c-protocol.rst | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
