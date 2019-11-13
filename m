From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v3 1/3] i2c: use void pointers for supplying data for
 reads and writes
Date: Wed, 13 Nov 2019 10:47:33 +0100
Message-ID: <c422deb2-9eb8-4111-d9bd-eeddbebf5eac@lucaceresoli.net>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
 <20191112203132.163306-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112203132.163306-2-dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-iio@vger.kernel.orgi, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>linux-iio@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Dmitry,

thanks for having taken into account my comments.

On 12/11/19 21:31, Dmitry Torokhov wrote:
> There is no need to force users of i2c_master_send()/i2c_master_recv()
> and other i2c read/write bulk data API to cast everything into u8 pointers.
> While everything can be considered byte stream, the drivers are usually
> work with more structured data.
> 
> Let's switch the APIs to accept [const] void pointers to cut amount of
> casting needed.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
