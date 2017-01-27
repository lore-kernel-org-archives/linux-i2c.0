From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 05/12] dt-bindings: iio: io-channel-mux: document
 io-channel-mux bindings
Date: Fri, 27 Jan 2017 13:12:09 -0600
Message-ID: <20170127191209.tamt34jy5fyx3mnm@rob-hp-laptop>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-6-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484755035-25927-6-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 18, 2017 at 04:57:08PM +0100, Peter Rosin wrote:
> Describe how a multiplexer can be used to select which signal is fed to
> an io-channel.
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/iio/multiplexer/io-channel-mux.txt    | 39 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt

Acked-by: Rob Herring <robh@kernel.org>
