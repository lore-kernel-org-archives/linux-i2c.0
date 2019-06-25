From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 01/34] clk: clk-cdce706: simplify getting the adapter of a client
Date: Tue, 25 Jun 2019 15:55:52 -0700
Message-ID: <20190625225553.10DBC2086D@mail.kernel.org>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com> <20190608105619.593-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Quoting Wolfram Sang (2019-06-08 03:55:40)
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied to clk-next
