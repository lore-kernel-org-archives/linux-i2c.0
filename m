From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv3 3/4] dt-bindings: i2c: Add Altera I2C Controller
Date: Thu, 8 Jun 2017 17:21:50 -0500
Message-ID: <20170608222150.xxlrzrfhhqqvuovl@rob-hp-laptop>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
 <1496447559-19782-4-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33293 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbdFHWVw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Jun 2017 18:21:52 -0400
Content-Disposition: inline
In-Reply-To: <1496447559-19782-4-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: thor.thayer@linux.intel.com
Cc: wsa@the-dreams.de, mark.rutland@arm.com, dinguyen@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 02, 2017 at 06:52:38PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the documentation to support the Altera synthesizable
> logic I2C Controller in FPGA.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  Change the subject to identify dt-bindings
>     Add synthesizable logic to description.
>     Change compatible string to "altr,softip-i2c"
>     Make description of clock phandle singular since 1 clock.
>     Remove altr, from fifo-size
>     Specify fifo-size is in bytes.
> v3  Add version to compatible string "altr,softip-i2c-v1.0"
>     Add for use in FPGA in description.
> ---
>  .../devicetree/bindings/i2c/i2c-altera.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt

Acked-by: Rob Herring <robh@kernel.org>
