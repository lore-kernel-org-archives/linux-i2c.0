From: Peter Rosin <peda@axentia.se>
Subject: Re: [patch v5] i2c: mux: mellanox: add driver
Date: Fri, 23 Sep 2016 11:36:10 +0200
Message-ID: <c530714e-b61e-8a38-a054-9d335f0e8a71@axentia.se>
References: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0118.outbound.protection.outlook.com ([104.47.2.118]:21952
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965725AbcIWPLQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 23 Sep 2016 11:11:16 -0400
In-Reply-To: <1473799071-12830-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>

On 2016-09-13 22:37, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
> 
> This driver allows I2C routing controlled through CPLD select registers on
> a wide range of Mellanox systems (CPLD Lattice device).
> MUX selection is provided by digital and analog HW. Analog part is not
> under SW control.
> Digital part is under CPLD control (channel selection/de-selection).
> 
> Connectivity schema.
> i2c-mlxcpld                                 Digital               Analog
> driver
> *--------*                                 * -> mux1 (virt bus2) -> mux ->|
> | I2CLPC | i2c physical                    * -> mux2 (virt bus3) -> mux ->|
> | bridge | bus 1                 *---------*                              |
> | logic  |---------------------> * mux reg *                              |
> | in CPLD|                       *---------*                              |
> *--------*   i2c-mux-mlxpcld          ^    * -> muxn (virt busn) -> mux ->|
>     |        driver                   |                                   |
>     |        *---------------*        |                             Devices
>     |        * CPLD (i2c bus)* select |
>     |        * registers for *--------*
>     |        * mux selection * deselect
>     |        *---------------*
>     |                 |
> <-------->     <----------->
> i2c cntrl      Board cntrl reg
> reg space      space (mux select,
>                IO, LED, WD, info)

Hmm, I'm wondering about the above schematics, which seems a bit
overly complex. I mean, it's not relevant to this driver how the
I2CLPC bridge logic in the CPLD is controlled. Particularly so
since it does not need to be a this particular i2c adapter that
is muxed.

But what I'm really wondering is if this mux can mux same other
bus than is used to control the mux. I.e. is it possible to do
something like this:

  .---.          .-------------.
  |   |          |             |-- i2c2 --
  | l |-- i2c0 --| mlxcpld mux |
  | i |          |             |-- i2c3 --
  | n |          '-------------'
  | u |                 |
  | x |-- i2c1 ---------'
  |   |
  '---'

Or is it always as below, with the mux being controlled from
the same i2c bus it muxes?

  .---.             .-------------.
  | l |             |             |-- i2c1 --
  | i |-- i2c0 --+--| mlxcpld mux |
  | n |          |  |             |-- i2c2 --
  | u |          |  '-------------'
  | x |          |         |
  '---'          '---------'

Cheers,
Peter
