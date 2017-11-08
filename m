From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools: i2cbusses: Avoid buffer overflows in sysfs paths
Date: Wed, 8 Nov 2017 09:57:52 +0100
Message-ID: <20171108095752.300e95c6@endymion>
References: <20171031081604.18a9ca54@endymion>
        <20171106120426.lyo6azbrxxok4gan@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdKHI5z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 8 Nov 2017 03:57:55 -0500
In-Reply-To: <20171106120426.lyo6azbrxxok4gan@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

Hi Uwe,

Thanks for the review, very appreciated.

On Mon, 6 Nov 2017 13:04:26 +0100, Uwe Kleine-König wrote:
> Hello Jean,
> 
> On Tue, Oct 31, 2017 at 08:16:04AM +0100, Jean Delvare wrote:
> > sprintf isn't safe, use snprintf instead.
> > ---
> >  tools/i2cbusses.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > --- a/tools/i2cbusses.c
> > +++ b/tools/i2cbusses.c
> > @@ -220,18 +220,18 @@ struct i2c_adap *gather_i2c_busses(void)
> >  
> >  		/* this should work for kernels 2.6.5 or higher and */
> >  		/* is preferred because is unambiguous */
> > -		sprintf(n, "%s/%s/name", sysfs, de->d_name);
> > +		snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);  
> 
> OK, now instead of running in a buffer overflow in sprintf you might
> call fopen with a partial (maybe unterminated?) filename. While this is
> definitively better, you should check the return value of snprintf to be
> completely safe here.

To be honest, I never thought the buffer overflows could ever happen,
my motivation to fix them was to allow the code to build in OBS, where
FORTIFY_SOURCE is enabled. So I went for the most simple change that
made gcc happy.

That being said, I have no problem additionally checking the value
returned by snprintf. Something like this?

From: Jean Delvare
Subject: i2cbusses: Check the return value of snprintf

It's very unlikely that these paths will ever be truncated, but
better safe than sorry.
---
 tools/i2cbusses.c |   34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

--- i2c-tools.orig/tools/i2cbusses.c	2017-11-02 16:17:50.698383029 +0100
+++ i2c-tools/tools/i2cbusses.c	2017-11-08 09:49:40.365339644 +0100
@@ -137,7 +137,7 @@ struct i2c_adap *gather_i2c_busses(void)
 	FILE *f;
 	char fstype[NAME_MAX], sysfs[NAME_MAX], n[NAME_MAX];
 	int foundsysfs = 0;
-	int count=0;
+	int len, count = 0;
 	struct i2c_adap *adapters;
 
 	adapters = calloc(BUNCH, sizeof(struct i2c_adap));
@@ -220,18 +220,32 @@ struct i2c_adap *gather_i2c_busses(void)
 
 		/* this should work for kernels 2.6.5 or higher and */
 		/* is preferred because is unambiguous */
-		snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);
+		len = snprintf(n, NAME_MAX, "%s/%s/name", sysfs, de->d_name);
+		if (len >= NAME_MAX) {
+			fprintf(stderr, "%s: path truncated\n", n);
+			continue;
+		}
 		f = fopen(n, "r");
 		/* this seems to work for ISA */
 		if(f == NULL) {
-			snprintf(n, NAME_MAX, "%s/%s/device/name", sysfs, de->d_name);
+			len = snprintf(n, NAME_MAX, "%s/%s/device/name", sysfs,
+				       de->d_name);
+			if (len >= NAME_MAX) {
+				fprintf(stderr, "%s: path truncated\n", n);
+				continue;
+			}
 			f = fopen(n, "r");
 		}
 		/* non-ISA is much harder */
 		/* and this won't find the correct bus name if a driver
 		   has more than one bus */
 		if(f == NULL) {
-			snprintf(n, NAME_MAX, "%s/%s/device", sysfs, de->d_name);
+			len = snprintf(n, NAME_MAX, "%s/%s/device", sysfs,
+				       de->d_name);
+			if (len >= NAME_MAX) {
+				fprintf(stderr, "%s: path truncated\n", n);
+				continue;
+			}
 			if(!(ddir = opendir(n)))
 				continue;
 			while ((dde = readdir(ddir)) != NULL) {
@@ -240,8 +254,16 @@ struct i2c_adap *gather_i2c_busses(void)
 				if (!strcmp(dde->d_name, ".."))
 					continue;
 				if ((!strncmp(dde->d_name, "i2c-", 4))) {
-					snprintf(n, NAME_MAX, "%s/%s/device/%s/name",
-						 sysfs, de->d_name, dde->d_name);
+					len = snprintf(n, NAME_MAX,
+						       "%s/%s/device/%s/name",
+						       sysfs, de->d_name,
+						       dde->d_name);
+					if (len >= NAME_MAX) {
+						fprintf(stderr,
+							"%s: path truncated\n",
+							n);
+						continue;
+					}
 					if((f = fopen(n, "r")))
 						goto found;
 				}


-- 
Jean Delvare
SUSE L3 Support
