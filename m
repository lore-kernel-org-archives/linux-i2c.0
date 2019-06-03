From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c: mux: pinctrl: use flexible-array member and
 struct_size() helper
Date: Mon, 3 Jun 2019 09:53:35 -0500
Message-ID: <20190603145335.GA2743@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Update the code to use a flexible array member instead of a pointer in
structure i2c_mux_pinctrl and use the struct_size() helper.

Also, make use of the struct_size() helper instead of an open-coded
version in order to avoid any potential type mistakes, in particular
in the context in which this code is being used.

So, replace the following form:

sizeof(*mux) + num_names * sizeof(*mux->states)

with:

struct_size(mux, states, num_names)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/muxes/i2c-mux-pinctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
index cc6818aabab5..ff3e8c9d4dd8 100644
--- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
@@ -27,7 +27,7 @@
 
 struct i2c_mux_pinctrl {
 	struct pinctrl *pinctrl;
-	struct pinctrl_state **states;
+	struct pinctrl_state *states[];
 };
 
 static int i2c_mux_pinctrl_select(struct i2c_mux_core *muxc, u32 chan)
@@ -104,14 +104,13 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(parent);
 
 	muxc = i2c_mux_alloc(parent, dev, num_names,
-			     sizeof(*mux) + num_names * sizeof(*mux->states),
+			     struct_size(mux, states, num_names),
 			     0, i2c_mux_pinctrl_select, NULL);
 	if (!muxc) {
 		ret = -ENOMEM;
 		goto err_put_parent;
 	}
 	mux = i2c_mux_priv(muxc);
-	mux->states = (struct pinctrl_state **)(mux + 1);
 
 	platform_set_drvdata(pdev, muxc);
 
-- 
2.21.0
