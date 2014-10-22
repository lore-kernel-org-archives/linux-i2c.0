From: John de la Garza <john-RXdYNANpVgkAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add generic support passing secondary devices
 addresses
Date: Wed, 22 Oct 2014 16:05:00 -0400
Message-ID: <20141022200457.GA3200@vega.jjdev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

instead of:

+	np = client->dev.of_node;
+
+	if (np) {
+		i = of_property_match_string(np, "reg-names", name);
+		if (i >= 0)
+			of_property_read_u32_index(np, "reg", i, &addr);
+		else if (default_addr != 0)
+			addr = default_addr;
+		else
+			addr = NULL;
+	} else {
+		addr = default_addr;
+	}


how about making the middle part like this to remove the repeated code

	np = client->dev.of_node;
	addr = default_addr;

	if (np) {
		i = of_property_match_string(np, "reg-names", name);
		if (i >= 0)
			of_property_read_u32_index(np, "reg", i, &addr);
		else if (default_addr == 0)
			addr = NULL;
	}
