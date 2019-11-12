From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH] i2c: remove helpers for ref-counting clients
Date: Tue, 12 Nov 2019 08:59:36 +0100
Message-ID: <90246cbb-5013-0144-d2a3-ba30b745a86d@lucaceresoli.net>
References: <20191109212615.9254-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191109212615.9254-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 09/11/19 22:26, Wolfram Sang wrote:
> There are no in-tree users of these helpers anymore, and there
> shouldn't. Most use cases went away once the driver model started to
> refcount for us. There have been users like the media subsystem, but
> they all switched to better refcounting methods meanwhile. Media did
> this in 2008. Last user (IPMI) left 2018. Remove this cruft.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

[Tested on older kernel + TI serdes patches]
Tested-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
