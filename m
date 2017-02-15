From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 07/10] dt-bindings: i2c: i2c-mux: document general
 purpose i2c-mux bindings
Date: Wed, 15 Feb 2017 16:55:26 -0600
Message-ID: <20170215225526.rurmorrgd6roesaa@rob-hp-laptop>
References: <1486568517-6997-1-git-send-email-peda@axentia.se>
 <1486568517-6997-8-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486568517-6997-8-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 08, 2017 at 04:41:54PM +0100, Peter Rosin wrote:
> Describe how a general purpose multiplexer controller is used to mux an
> i2c bus.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-gpmux.txt      | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpmux.txt

Reviewed-by: Rob Herring <robh@kernel.org>
