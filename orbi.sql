--
-- PostgreSQL database dump
--

\restrict gnavvXhHaVNkaCGmrmu9VTDHb96boaFavLKZ4JtpgXOclwYerAsyj7IatQvA8D8

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-14 16:16:42

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 23187)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3750 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 888 (class 1247 OID 23288)
-- Name: BroadcastStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."BroadcastStatus" AS ENUM (
    'DRAFT',
    'SCHEDULED',
    'SENDING',
    'COMPLETED',
    'FAILED',
    'CANCELLED'
);


ALTER TYPE public."BroadcastStatus" OWNER TO postgres;

--
-- TOC entry 885 (class 1247 OID 23278)
-- Name: ConversationStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ConversationStatus" AS ENUM (
    'OPEN',
    'ASSIGNED',
    'RESOLVED',
    'CLOSED'
);


ALTER TYPE public."ConversationStatus" OWNER TO postgres;

--
-- TOC entry 894 (class 1247 OID 23312)
-- Name: InvoiceStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."InvoiceStatus" AS ENUM (
    'PENDING',
    'PAID',
    'OVERDUE',
    'CANCELLED',
    'REFUNDED'
);


ALTER TYPE public."InvoiceStatus" OWNER TO postgres;

--
-- TOC entry 873 (class 1247 OID 23230)
-- Name: MessageChannel; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."MessageChannel" AS ENUM (
    'WHATSAPP',
    'SMS',
    'EMAIL'
);


ALTER TYPE public."MessageChannel" OWNER TO postgres;

--
-- TOC entry 876 (class 1247 OID 23238)
-- Name: MessageStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."MessageStatus" AS ENUM (
    'PENDING',
    'QUEUED',
    'SENT',
    'DELIVERED',
    'READ',
    'FAILED',
    'CANCELLED'
);


ALTER TYPE public."MessageStatus" OWNER TO postgres;

--
-- TOC entry 951 (class 1247 OID 23674)
-- Name: PaymentMethodType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PaymentMethodType" AS ENUM (
    'CARD',
    'UPI',
    'NETBANKING',
    'WALLET'
);


ALTER TYPE public."PaymentMethodType" OWNER TO postgres;

--
-- TOC entry 948 (class 1247 OID 23664)
-- Name: SubscriberStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SubscriberStatus" AS ENUM (
    'ACTIVE',
    'UNSUBSCRIBED',
    'BOUNCED',
    'COMPLAINED'
);


ALTER TYPE public."SubscriberStatus" OWNER TO postgres;

--
-- TOC entry 867 (class 1247 OID 23210)
-- Name: SubscriptionPlan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SubscriptionPlan" AS ENUM (
    'FREE',
    'STARTER',
    'PROFESSIONAL',
    'ENTERPRISE'
);


ALTER TYPE public."SubscriptionPlan" OWNER TO postgres;

--
-- TOC entry 879 (class 1247 OID 23254)
-- Name: TemplateCategory; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TemplateCategory" AS ENUM (
    'MARKETING',
    'OTP',
    'ALERT',
    'NOTIFICATION',
    'TRANSACTIONAL',
    'CUSTOM',
    'UTILITY',
    'AUTHENTICATION'
);


ALTER TYPE public."TemplateCategory" OWNER TO postgres;

--
-- TOC entry 882 (class 1247 OID 23268)
-- Name: TemplateStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TemplateStatus" AS ENUM (
    'DRAFT',
    'PENDING_APPROVAL',
    'APPROVED',
    'REJECTED'
);


ALTER TYPE public."TemplateStatus" OWNER TO postgres;

--
-- TOC entry 864 (class 1247 OID 23198)
-- Name: TenantStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TenantStatus" AS ENUM (
    'ACTIVE',
    'SUSPENDED',
    'TRIAL',
    'PAST_DUE',
    'CANCELED'
);


ALTER TYPE public."TenantStatus" OWNER TO postgres;

--
-- TOC entry 870 (class 1247 OID 23220)
-- Name: UserRole; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."UserRole" AS ENUM (
    'SUPER_ADMIN',
    'ADMIN',
    'MEMBER',
    'VIEWER'
);


ALTER TYPE public."UserRole" OWNER TO postgres;

--
-- TOC entry 891 (class 1247 OID 23302)
-- Name: WorkflowRunStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."WorkflowRunStatus" AS ENUM (
    'RUNNING',
    'COMPLETED',
    'FAILED',
    'CANCELLED'
);


ALTER TYPE public."WorkflowRunStatus" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 23188)
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 23464)
-- Name: api_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_keys (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    name text NOT NULL,
    key text NOT NULL,
    secret text NOT NULL,
    permissions jsonb,
    "rateLimit" integer DEFAULT 100 NOT NULL,
    "rateLimitWindow" integer DEFAULT 900 NOT NULL,
    "lastUsedAt" timestamp(3) without time zone,
    "requestCount" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "expiresAt" timestamp(3) without time zone
);


ALTER TABLE public.api_keys OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 23476)
-- Name: api_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_logs (
    id text NOT NULL,
    "apiKeyId" text NOT NULL,
    method text NOT NULL,
    path text NOT NULL,
    "ipAddress" text NOT NULL,
    "userAgent" text,
    "statusCode" integer NOT NULL,
    "responseTime" integer NOT NULL,
    error text,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.api_logs OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 23484)
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id text NOT NULL,
    "tenantId" text,
    "userId" text,
    action text NOT NULL,
    "resourceType" text,
    "resourceId" text,
    "ipAddress" text,
    "userAgent" text,
    metadata jsonb,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 23427)
-- Name: broadcast_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broadcast_messages (
    id text NOT NULL,
    "broadcastId" text NOT NULL,
    "messageId" text NOT NULL
);


ALTER TABLE public.broadcast_messages OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 23414)
-- Name: broadcasts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broadcasts (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    name text NOT NULL,
    channel public."MessageChannel" NOT NULL,
    "segmentId" text,
    "contactIds" text[],
    "templateId" text,
    body text NOT NULL,
    variables jsonb,
    "scheduledAt" timestamp(3) without time zone,
    "sentAt" timestamp(3) without time zone,
    status public."BroadcastStatus" DEFAULT 'DRAFT'::public."BroadcastStatus" NOT NULL,
    "totalContacts" integer DEFAULT 0 NOT NULL,
    "sentCount" integer DEFAULT 0 NOT NULL,
    "deliveredCount" integer DEFAULT 0 NOT NULL,
    "failedCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "mediaType" text,
    "mediaUrl" text
);


ALTER TABLE public.broadcasts OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 23388)
-- Name: contact_segments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_segments (
    "contactId" text NOT NULL,
    "segmentId" text NOT NULL
);


ALTER TABLE public.contact_segments OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 23369)
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    phone text,
    email text,
    "firstName" text,
    "lastName" text,
    name text,
    "customFields" jsonb,
    tags text[],
    source text,
    "isBlocked" boolean DEFAULT false NOT NULL,
    "optedOut" boolean DEFAULT false NOT NULL,
    "lastMessageAt" timestamp(3) without time zone,
    "lastMessageStatus" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "isDeleted" boolean DEFAULT false NOT NULL
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 23406)
-- Name: conversation_assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversation_assignments (
    id text NOT NULL,
    "conversationId" text NOT NULL,
    "userId" text NOT NULL,
    "assignedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "resolvedAt" timestamp(3) without time zone
);


ALTER TABLE public.conversation_assignments OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 23395)
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    "contactId" text NOT NULL,
    phone text NOT NULL,
    channel public."MessageChannel" DEFAULT 'WHATSAPP'::public."MessageChannel" NOT NULL,
    status public."ConversationStatus" DEFAULT 'OPEN'::public."ConversationStatus" NOT NULL,
    "isRead" boolean DEFAULT false NOT NULL,
    "lastMessageAt" timestamp(3) without time zone,
    labels text[],
    metadata jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "closedAt" timestamp(3) without time zone
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 23454)
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    "razorpayInvoiceId" text,
    "razorpayPaymentId" text,
    "invoiceNumber" text NOT NULL,
    amount numeric(10,2) NOT NULL,
    currency text DEFAULT 'INR'::text NOT NULL,
    status public."InvoiceStatus" DEFAULT 'PENDING'::public."InvoiceStatus" NOT NULL,
    "periodStart" timestamp(3) without time zone NOT NULL,
    "periodEnd" timestamp(3) without time zone NOT NULL,
    items jsonb NOT NULL,
    "paidAt" timestamp(3) without time zone,
    "dueDate" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 23347)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    "conversationId" text,
    "contactId" text,
    "to" text NOT NULL,
    channel public."MessageChannel" NOT NULL,
    body text NOT NULL,
    "templateId" text,
    variables jsonb,
    "mediaUrl" text,
    "mediaType" text,
    status public."MessageStatus" DEFAULT 'PENDING'::public."MessageStatus" NOT NULL,
    provider text,
    "providerMessageId" text,
    "providerError" text,
    "scheduledAt" timestamp(3) without time zone,
    "sentAt" timestamp(3) without time zone,
    "deliveredAt" timestamp(3) without time zone,
    "readAt" timestamp(3) without time zone,
    "retryCount" integer DEFAULT 0 NOT NULL,
    "maxRetries" integer DEFAULT 3 NOT NULL,
    "webhookUrl" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "from" text
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 23699)
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_methods (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    type public."PaymentMethodType" NOT NULL,
    "razorpayPaymentMethodId" text,
    last4 text,
    brand text,
    "expiryMonth" integer,
    "expiryYear" integer,
    "isDefault" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "billingDetails" jsonb,
    metadata jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "deletedAt" timestamp(3) without time zone
);


ALTER TABLE public.payment_methods OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 23379)
-- Name: segments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.segments (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    name text NOT NULL,
    description text,
    filters jsonb NOT NULL,
    "contactCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.segments OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 23687)
-- Name: subscribers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscribers (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    email text NOT NULL,
    phone text,
    "firstName" text,
    "lastName" text,
    status public."SubscriberStatus" DEFAULT 'ACTIVE'::public."SubscriberStatus" NOT NULL,
    source text DEFAULT 'manual'::text NOT NULL,
    tags text[],
    "customFields" jsonb,
    "subscribedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "unsubscribedAt" timestamp(3) without time zone,
    "lastEmailSentAt" timestamp(3) without time zone,
    "emailVerified" boolean DEFAULT false NOT NULL,
    "emailVerificationToken" text,
    "verifiedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "deletedAt" timestamp(3) without time zone
);


ALTER TABLE public.subscribers OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 23358)
-- Name: templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.templates (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    name text NOT NULL,
    category public."TemplateCategory" NOT NULL,
    channel public."MessageChannel" NOT NULL,
    body text NOT NULL,
    variables jsonb,
    language text DEFAULT 'en'::text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "providerTemplateId" text,
    status public."TemplateStatus" DEFAULT 'DRAFT'::public."TemplateStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    feature text,
    identifier text,
    industry text
);


ALTER TABLE public.templates OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 23758)
-- Name: tenant_meta_credentials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_meta_credentials (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    "appId" text NOT NULL,
    "appSecret" text NOT NULL,
    "accessToken" text NOT NULL,
    "phoneNumberId" text NOT NULL,
    "wabaId" text NOT NULL,
    "webhookVerifyToken" text NOT NULL,
    "apiVersion" text DEFAULT 'v23.0'::text NOT NULL,
    "apiBaseUrl" text DEFAULT 'https://graph.facebook.com'::text NOT NULL,
    "webhookUrl" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "webhookSecret" text
);


ALTER TABLE public.tenant_meta_credentials OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 23323)
-- Name: tenants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenants (
    id text NOT NULL,
    slug text NOT NULL,
    name text NOT NULL,
    subdomain text,
    "customDomain" text,
    logo text,
    "brandColors" jsonb,
    status public."TenantStatus" DEFAULT 'ACTIVE'::public."TenantStatus" NOT NULL,
    plan public."SubscriptionPlan" DEFAULT 'FREE'::public."SubscriptionPlan" NOT NULL,
    "razorpayCustomerId" text,
    "razorpaySubscriptionId" text,
    "trialEndsAt" timestamp(3) without time zone,
    "subscriptionStartsAt" timestamp(3) without time zone,
    "subscriptionEndsAt" timestamp(3) without time zone,
    "messageQuota" integer DEFAULT 1000 NOT NULL,
    "messageUsed" integer DEFAULT 0 NOT NULL,
    "quotaResetAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    features jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "deletedAt" timestamp(3) without time zone,
    "emailSettings" jsonb,
    "whatsappSettings" jsonb
);


ALTER TABLE public.tenants OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 23336)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "firstName" text,
    "lastName" text,
    phone text,
    avatar text,
    role public."UserRole" DEFAULT 'MEMBER'::public."UserRole" NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "lastLoginAt" timestamp(3) without time zone,
    "twoFactorEnabled" boolean DEFAULT false NOT NULL,
    "twoFactorSecret" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "deletedAt" timestamp(3) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 23709)
-- Name: waba_connections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.waba_connections (
    id text NOT NULL,
    "userId" text NOT NULL,
    "tenantId" text NOT NULL,
    "accessToken" text NOT NULL,
    "refreshToken" text,
    "tokenExpiresAt" timestamp(3) without time zone NOT NULL,
    "businessId" text NOT NULL,
    "businessName" text,
    "wabaId" text NOT NULL,
    "wabaName" text,
    "phoneNumbers" jsonb,
    "isActive" boolean DEFAULT true NOT NULL,
    "connectedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.waba_connections OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 23445)
-- Name: workflow_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_runs (
    id text NOT NULL,
    "workflowId" text NOT NULL,
    "tenantId" text NOT NULL,
    "userId" text,
    "contactId" text,
    "triggerType" text NOT NULL,
    "triggerData" jsonb,
    status public."WorkflowRunStatus" DEFAULT 'RUNNING'::public."WorkflowRunStatus" NOT NULL,
    "currentNodeId" text,
    error text,
    "startedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "completedAt" timestamp(3) without time zone
);


ALTER TABLE public.workflow_runs OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 23434)
-- Name: workflows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflows (
    id text NOT NULL,
    "tenantId" text NOT NULL,
    name text NOT NULL,
    description text,
    flow jsonb NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "isPaused" boolean DEFAULT false NOT NULL,
    "runsCount" integer DEFAULT 0 NOT NULL,
    "lastRunAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.workflows OWNER TO postgres;

--
-- TOC entry 3723 (class 0 OID 23188)
-- Dependencies: 215
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
e59579e8-6138-428e-ada2-639fcf1d1e0a	bd9c4dcc2dd0f57bd738677c5299072c39b7e1895781412fb28bb779df6b325d	2025-12-13 12:43:14.38349+05:30	20251104140728_	\N	\N	2025-12-13 12:43:13.559739+05:30	1
1eb93867-ed8f-4a82-891e-e2ede5c67cf8	2302acff299b63893839d8fc206da92592d8dd22f1294994ef99b547d7622eab	2025-12-13 12:43:14.659513+05:30	20251105154920_	\N	\N	2025-12-13 12:43:14.404056+05:30	1
a16a1761-25f8-44dd-a422-af6fcdc74ae9	28d487f014783abb4781869ea62b883f1a1795dae9e13add137a3005ea8d3019	2025-12-13 12:43:14.756818+05:30	20251120062152_add_tenant_meta_credentials	\N	\N	2025-12-13 12:43:14.684167+05:30	1
934c256d-ce84-42f5-9569-8a03ff8a8bc5	2db1b8c437f6352014c9f980f56a871a1f884f46b9eb661c9fda714c94c2a365	2025-12-13 12:43:14.832368+05:30	20251122101358_add_from_field_to_messages	\N	\N	2025-12-13 12:43:14.779257+05:30	1
c3117313-d892-48f4-b832-a4fc45f091e3	d53f55aa8799b83e963ae6206aa08533a58c3a35a968ab245e59021edd4bf57f	2025-12-13 12:43:14.906829+05:30	20251124055500_add_webhook_secret	\N	\N	2025-12-13 12:43:14.851889+05:30	1
230525f9-a81c-4242-9743-05239ad33d6b	20ac6a110032cc0ebf7a16f2124388b102a9ded49379e8891026519b45cc62a0	2025-12-13 12:43:15.192399+05:30	20251124064002_add_media_to_broadcasts	\N	\N	2025-12-13 12:43:14.926938+05:30	1
30225935-f8e1-43e1-a6a8-5c377da62e1b	7a63871274dd1650a644a95d767dfe74b7035b1f6c7f46bbc4f91efb35ccb662	2025-12-13 12:43:15.452642+05:30	20251126090000_add_flow_builder	\N	\N	2025-12-13 12:43:15.214404+05:30	1
eba7da21-733e-4b9a-94ff-5381ba9fa542	b18e36b739bed1bb13d4ec0b78ac0a096ccbd77ef7933b19215a41ee793262a3	2025-12-13 12:43:15.557753+05:30	20251213070707_	\N	\N	2025-12-13 12:43:15.472051+05:30	1
4855c463-289c-4d0a-b7c7-7e85d81c137e	3dcb12fa5834c5aff2d9e5bf108f37b9c2d6543beaabef58d48c7aaf6b6d3790	2025-11-29 15:44:29.453539+05:30	20251129101428_soft_delete_for_segments	\N	\N	2025-11-29 15:44:28.739187+05:30	1
baf02285-3f09-4c83-8cf6-3ab9ed6ca939	bd9c4dcc2dd0f57bd738677c5299072c39b7e1895781412fb28bb779df6b325d	2025-11-25 12:09:35.902577+05:30	20251104145106_	\N	\N	2025-11-25 12:09:35.323569+05:30	1
dd69d169-8cb4-4426-b101-dca0dfa10e80	65423ab5a3d3cde46fc684fb0d72ab30267af97e081de4f664692b89fee6332f	2025-11-25 12:09:36.315406+05:30	20251105053446_	\N	\N	2025-11-25 12:09:35.992977+05:30	1
9a82b8b9-95bc-4029-8c49-0ebaf109890a	a744e6a317e0ed0f9a09ea67738d954dce60e6cac3ad7017b4929618ceb23fe9	2025-11-25 12:09:45.773541+05:30	20251125063945_	\N	\N	2025-11-25 12:09:45.436739+05:30	1
\.


--
-- TOC entry 3738 (class 0 OID 23464)
-- Dependencies: 230
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_keys (id, "tenantId", name, key, secret, permissions, "rateLimit", "rateLimitWindow", "lastUsedAt", "requestCount", "isActive", "createdAt", "updatedAt", "expiresAt") FROM stdin;
\.


--
-- TOC entry 3739 (class 0 OID 23476)
-- Dependencies: 231
-- Data for Name: api_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_logs (id, "apiKeyId", method, path, "ipAddress", "userAgent", "statusCode", "responseTime", error, "timestamp") FROM stdin;
\.


--
-- TOC entry 3740 (class 0 OID 23484)
-- Dependencies: 232
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, "tenantId", "userId", action, "resourceType", "resourceId", "ipAddress", "userAgent", metadata, "timestamp") FROM stdin;
\.


--
-- TOC entry 3734 (class 0 OID 23427)
-- Dependencies: 226
-- Data for Name: broadcast_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broadcast_messages (id, "broadcastId", "messageId") FROM stdin;
5d43f2b5-e1ee-45e3-ad65-516bb7698b4f	77f1c2f3-06be-4a7e-a478-cbaed1baf84d	43410a86-4307-45c6-ae19-10f17ff07e61
52a5a435-ea77-412e-ba46-37761c62ec90	77f1c2f3-06be-4a7e-a478-cbaed1baf84d	ef0990b5-6608-48bf-8008-afd24cd68be4
31eb6683-89b4-4b0e-b4ca-31bb9ea8e8c4	77d36a00-2d0e-4b89-bbe9-e12516e227ca	66117882-90a1-4bd1-967e-549dfe5af6b9
938418b3-9345-42a4-be13-68fc88d28192	77d36a00-2d0e-4b89-bbe9-e12516e227ca	67337d31-b4aa-40de-9dfa-29de8161f20b
0e2f98b9-8d9f-4671-8ba5-fff1ec37c7ed	3d7208ac-affe-47d9-a87d-86b4d452f196	9df106af-eb0f-4282-a446-9920beeb6c44
6d60aad4-73a5-4078-a2bd-494e767a9c2e	3d7208ac-affe-47d9-a87d-86b4d452f196	3169a5d6-d8d4-4b67-997f-d7b98c63fc83
4ad7ddeb-ba2f-43ba-aa70-777be01a862f	c79654a8-1bb7-4e7b-8c75-e7fae2f7d353	b65174aa-21f4-4fda-abed-1d800b69576b
dd13f042-6318-4a25-86b8-0501b1e9d14d	b992614b-e892-4e0f-a5b9-53580f8938e7	3188cb94-025a-42a5-a731-a7ad469bb93f
da682311-50c1-459a-8e57-9447b4100830	b992614b-e892-4e0f-a5b9-53580f8938e7	7f858a45-a452-47ce-af41-a8a06a24f1b8
4d9d6930-61cb-4541-8507-9f5646230374	80c2bc39-34f0-49d6-a144-7e8afeba6fa8	25b7ce04-6bd8-43d3-b723-88db3562b568
e07bbc60-2716-4594-ab2b-b6db460916f3	80c2bc39-34f0-49d6-a144-7e8afeba6fa8	365dd436-5c27-4836-9ad9-376c38e67a9b
e5695668-a9eb-4561-9b97-15ae49d98895	80c2bc39-34f0-49d6-a144-7e8afeba6fa8	397a23c1-ce01-4276-96b4-9bfd67486d70
6021456f-5987-4130-bfe7-aa1878c8e88c	80c2bc39-34f0-49d6-a144-7e8afeba6fa8	02d0c357-35e3-424e-a1f5-eef4e72fc295
\.


--
-- TOC entry 3733 (class 0 OID 23414)
-- Dependencies: 225
-- Data for Name: broadcasts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broadcasts (id, "tenantId", name, channel, "segmentId", "contactIds", "templateId", body, variables, "scheduledAt", "sentAt", status, "totalContacts", "sentCount", "deliveredCount", "failedCount", "createdAt", "updatedAt", "mediaType", "mediaUrl") FROM stdin;
36f8007c-76c6-4196-8be5-eb94ae3d6fc5	b77305a1-f7ba-4c83-9136-31aa4a94a7d5	dbproad cast	SMS	\N	{f1c9127c-a4b3-46b5-9a44-cae3f655d356}	\N	hi thid test message	{}	\N	\N	FAILED	1	0	0	1	2025-11-27 12:19:51.48	2025-11-27 12:19:52.83	\N	\N
970143f1-4a97-4665-8d9d-87ae013c0bd8	b77305a1-f7ba-4c83-9136-31aa4a94a7d5	Dbrod	EMAIL	\N	{f1c9127c-a4b3-46b5-9a44-cae3f655d356}	\N	hi ...	{}	\N	\N	FAILED	1	0	0	1	2025-11-27 12:32:07.595	2025-11-27 12:32:08.978	\N	\N
479623e5-b933-478a-b57f-e51e9e861896	b77305a1-f7ba-4c83-9136-31aa4a94a7d5	dbroad3	SMS	\N	{f1c9127c-a4b3-46b5-9a44-cae3f655d356,054d41ce-51b3-4f9b-8f37-2827190512c5}	\N	hiiiii	{}	\N	\N	FAILED	2	0	0	2	2025-11-27 12:40:21.78	2025-11-27 12:40:23.431	\N	\N
77f1c2f3-06be-4a7e-a478-cbaed1baf84d	babcdaf3-79b3-45f6-afb6-813d833b4bb2	Aditya Patil	WHATSAPP	\N	{ef481f64-6484-4ab0-bb1e-71cc6cc88ab6,1f9b67d9-7628-4e5b-8dc3-dbd205feba6d}	702bac9a-6a8a-4b43-ba5e-6be9ef5c59ae	Grow your business with smarter WhatsApp marketing\nOrbiFlow helps you reach customers instantly using the official WhatsApp Business API.\n\nSend bulk messages, automate follow-ups, and track delivery — all from one powerful dashboard.\n\n✅ Secure & compliant messaging\n✅ Bulk campaigns & templates\n✅ Real-time delivery insights\n✅ Built for scale & reliability	{}	\N	2025-12-14 09:50:57.43	FAILED	2	0	0	2	2025-12-14 09:50:56.033	2025-12-14 09:50:57.43	\N	\N
77d36a00-2d0e-4b89-bbe9-e12516e227ca	babcdaf3-79b3-45f6-afb6-813d833b4bb2	demo	WHATSAPP	\N	{ef481f64-6484-4ab0-bb1e-71cc6cc88ab6,1f9b67d9-7628-4e5b-8dc3-dbd205feba6d}	702bac9a-6a8a-4b43-ba5e-6be9ef5c59ae	Grow your business with smarter WhatsApp marketing\nOrbiFlow helps you reach customers instantly using the official WhatsApp Business API.\n\nSend bulk messages, automate follow-ups, and track delivery — all from one powerful dashboard.\n\n✅ Secure & compliant messaging\n✅ Bulk campaigns & templates\n✅ Real-time delivery insights\n✅ Built for scale & reliability	{}	\N	2025-12-14 09:52:34.662	FAILED	2	0	0	2	2025-12-14 09:52:33.433	2025-12-14 09:52:34.662	\N	\N
3d7208ac-affe-47d9-a87d-86b4d452f196	babcdaf3-79b3-45f6-afb6-813d833b4bb2	Aditya Patil	WHATSAPP	\N	{ef481f64-6484-4ab0-bb1e-71cc6cc88ab6,1f9b67d9-7628-4e5b-8dc3-dbd205feba6d}	57dff916-ea0a-4e55-8ab2-be6c5a74059e	🙏 *SRPF Command Dashboard* मध्ये आपले स्वागत आहे. \n*कृपया पर्याय निवडा:*	{}	\N	2025-12-14 09:54:36.859	FAILED	2	0	0	2	2025-12-14 09:54:35.341	2025-12-14 09:54:36.859	\N	\N
c79654a8-1bb7-4e7b-8c75-e7fae2f7d353	babcdaf3-79b3-45f6-afb6-813d833b4bb2	Aditya Patil	WHATSAPP	\N	{ef481f64-6484-4ab0-bb1e-71cc6cc88ab6}	7dcee5a4-2c08-4937-bdf1-2c8c47652138	Hello, Wolcome to the company	{}	\N	2025-12-14 09:57:48.467	COMPLETED	1	1	1	0	2025-12-14 09:57:46.438	2025-12-14 09:57:48.467	\N	\N
80c2bc39-34f0-49d6-a144-7e8afeba6fa8	babcdaf3-79b3-45f6-afb6-813d833b4bb2	test 101	WHATSAPP	\N	{ef481f64-6484-4ab0-bb1e-71cc6cc88ab6,1f9b67d9-7628-4e5b-8dc3-dbd205feba6d,900610c9-dec3-4f44-a32d-d6f09d7b175a,172535da-72ed-4426-82c2-1bee53b34885}	25c0f3ff-97ec-49c7-a2e2-90f0180e702e	Welcome and congratulations!! This message demonstrates your ability to send a WhatsApp message notification from the Cloud API, hosted by Meta. Thank you for taking the time to test with us.	{}	\N	2025-12-14 10:28:06.672	COMPLETED	4	3	3	1	2025-12-14 10:28:04.549	2025-12-14 10:28:06.672	\N	\N
b992614b-e892-4e0f-a5b9-53580f8938e7	babcdaf3-79b3-45f6-afb6-813d833b4bb2	Aditya Patil	WHATSAPP	\N	{ef481f64-6484-4ab0-bb1e-71cc6cc88ab6,1f9b67d9-7628-4e5b-8dc3-dbd205feba6d}	14995dd2-2fb2-49ad-9924-8baa13abc418	आपले स्वागत आहे 🙏\n*_कृपया पर्याय निवडा:_*	{}	\N	2025-12-14 09:58:32.564	COMPLETED	2	2	2	0	2025-12-14 09:58:30.542	2025-12-14 09:58:32.564	\N	\N
\.


--
-- TOC entry 3730 (class 0 OID 23388)
-- Dependencies: 222
-- Data for Name: contact_segments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_segments ("contactId", "segmentId") FROM stdin;
\.


--
-- TOC entry 3728 (class 0 OID 23369)
-- Dependencies: 220
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, "tenantId", phone, email, "firstName", "lastName", name, "customFields", tags, source, "isBlocked", "optedOut", "lastMessageAt", "lastMessageStatus", "createdAt", "updatedAt", "isDeleted") FROM stdin;
4668e8b8-a4bc-4f0f-b882-20d90fd292dc	45f915e6-26dd-4997-9e9a-b7cc246e50e3	1234567890	\N	\N	\N	\N	\N	\N	api	f	f	\N	\N	2025-12-01 05:54:31.662	2025-12-01 05:54:31.662	f
cf67645a-f3f5-4057-9424-b96ddecc4c93	076a4a0a-bc41-49ab-a882-61ac7a4cf201	4444	auser2@gmail.com	auser2	auser2l	\N	{}	{vip}	\N	f	f	\N	\N	2025-12-13 09:30:00.976	2025-12-13 09:33:30.037	f
324d41e2-5f17-469d-a0f9-9d570d1bff0f	076a4a0a-bc41-49ab-a882-61ac7a4cf201	+919370902057	patiladitya340@gmail.com	Aditya	Patil	Aditya Patil	{"PIMPALGAON BK": "Nashik"}	{Customer}	\N	f	f	\N	\N	2025-12-13 11:16:05.744	2025-12-13 11:16:05.744	f
ef481f64-6484-4ab0-bb1e-71cc6cc88ab6	babcdaf3-79b3-45f6-afb6-813d833b4bb2	+919370902057	aditya@navantra.in	aditya	Patil	aditya Patil	{"Pune": "sds"}	{adi}	\N	f	f	\N	\N	2025-12-14 07:31:10.327	2025-12-14 07:31:10.327	f
1f9b67d9-7628-4e5b-8dc3-dbd205feba6d	babcdaf3-79b3-45f6-afb6-813d833b4bb2	+918329842193	aishwarya@navantra.in	aish	navantra	aish navantra	{"aishwarya": "member"}	{idk}	\N	f	f	\N	\N	2025-12-14 07:32:49.533	2025-12-14 07:32:49.533	f
900610c9-dec3-4f44-a32d-d6f09d7b175a	babcdaf3-79b3-45f6-afb6-813d833b4bb2	+917517262376	rushi@avantra.in	rushi	Sir	rushi Sir	{"aura": "aura"}	{senior}	\N	f	f	\N	\N	2025-12-14 10:26:25.346	2025-12-14 10:26:25.346	f
172535da-72ed-4426-82c2-1bee53b34885	babcdaf3-79b3-45f6-afb6-813d833b4bb2	+918788209521	sarang@navantra.in	Mahesh	sir	Mahesh sir	{"senior": "senior"}	{senior}	\N	f	f	\N	\N	2025-12-14 10:27:27.545	2025-12-14 10:27:27.545	f
\.


--
-- TOC entry 3732 (class 0 OID 23406)
-- Dependencies: 224
-- Data for Name: conversation_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversation_assignments (id, "conversationId", "userId", "assignedAt", "resolvedAt") FROM stdin;
\.


--
-- TOC entry 3731 (class 0 OID 23395)
-- Dependencies: 223
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (id, "tenantId", "contactId", phone, channel, status, "isRead", "lastMessageAt", labels, metadata, "createdAt", "updatedAt", "closedAt") FROM stdin;
268bcd94-f2fa-4059-80ba-4a0b71c0fba8	45f915e6-26dd-4997-9e9a-b7cc246e50e3	4668e8b8-a4bc-4f0f-b882-20d90fd292dc	1234567890	WHATSAPP	OPEN	f	\N	\N	\N	2025-12-01 05:54:31.982	2025-12-01 05:54:31.982	\N
\.


--
-- TOC entry 3737 (class 0 OID 23454)
-- Dependencies: 229
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoices (id, "tenantId", "razorpayInvoiceId", "razorpayPaymentId", "invoiceNumber", amount, currency, status, "periodStart", "periodEnd", items, "paidAt", "dueDate", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3726 (class 0 OID 23347)
-- Dependencies: 218
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, "tenantId", "conversationId", "contactId", "to", channel, body, "templateId", variables, "mediaUrl", "mediaType", status, provider, "providerMessageId", "providerError", "scheduledAt", "sentAt", "deliveredAt", "readAt", "retryCount", "maxRetries", "webhookUrl", "createdAt", "updatedAt", "from") FROM stdin;
8121973f-2ddb-40bd-be92-c9e6e92877b6	45f915e6-26dd-4997-9e9a-b7cc246e50e3	268bcd94-f2fa-4059-80ba-4a0b71c0fba8	4668e8b8-a4bc-4f0f-b882-20d90fd292dc	1234567890	WHATSAPP	Hello from Orbi! This is a test message.	\N	\N	\N	\N	FAILED	\N	\N	WhatsApp credentials not configured. Please configure Meta credentials for this tenant in Super Admin.	\N	\N	\N	\N	0	3	\N	2025-12-01 05:54:32.145	2025-12-01 05:54:44.409	\N
0b006e97-b5c8-431c-8597-628ac7e15e92	45f915e6-26dd-4997-9e9a-b7cc246e50e3	268bcd94-f2fa-4059-80ba-4a0b71c0fba8	4668e8b8-a4bc-4f0f-b882-20d90fd292dc	1234567890	WHATSAPP	Hello from Orbi! This is a test message.	\N	\N	\N	\N	FAILED	\N	\N	WhatsApp credentials not configured. Please configure Meta credentials for this tenant in Super Admin.	\N	\N	\N	\N	0	3	\N	2025-12-02 04:37:11.453	2025-12-02 04:37:19.077	\N
43410a86-4307-45c6-ae19-10f17ff07e61	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	ef481f64-6484-4ab0-bb1e-71cc6cc88ab6	+919370902057	WHATSAPP	Grow your business with smarter WhatsApp marketing\nOrbiFlow helps you reach customers instantly using the official WhatsApp Business API.\n\nSend bulk messages, automate follow-ups, and track delivery — all from one powerful dashboard.\n\n✅ Secure & compliant messaging\n✅ Bulk campaigns & templates\n✅ Real-time delivery insights\n✅ Built for scale & reliability	702bac9a-6a8a-4b43-ba5e-6be9ef5c59ae	{}	\N	\N	FAILED	\N	\N	Access token has expired. Please reconnect your WhatsApp Business Account.	\N	\N	\N	\N	0	3	\N	2025-12-14 09:50:56.042	2025-12-14 09:50:57.233	\N
ef0990b5-6608-48bf-8008-afd24cd68be4	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	1f9b67d9-7628-4e5b-8dc3-dbd205feba6d	+918329842193	WHATSAPP	Grow your business with smarter WhatsApp marketing\nOrbiFlow helps you reach customers instantly using the official WhatsApp Business API.\n\nSend bulk messages, automate follow-ups, and track delivery — all from one powerful dashboard.\n\n✅ Secure & compliant messaging\n✅ Bulk campaigns & templates\n✅ Real-time delivery insights\n✅ Built for scale & reliability	702bac9a-6a8a-4b43-ba5e-6be9ef5c59ae	{}	\N	\N	FAILED	\N	\N	Access token has expired. Please reconnect your WhatsApp Business Account.	\N	\N	\N	\N	0	3	\N	2025-12-14 09:50:56.054	2025-12-14 09:50:57.428	\N
66117882-90a1-4bd1-967e-549dfe5af6b9	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	ef481f64-6484-4ab0-bb1e-71cc6cc88ab6	+919370902057	WHATSAPP	Grow your business with smarter WhatsApp marketing\nOrbiFlow helps you reach customers instantly using the official WhatsApp Business API.\n\nSend bulk messages, automate follow-ups, and track delivery — all from one powerful dashboard.\n\n✅ Secure & compliant messaging\n✅ Bulk campaigns & templates\n✅ Real-time delivery insights\n✅ Built for scale & reliability	702bac9a-6a8a-4b43-ba5e-6be9ef5c59ae	{}	\N	\N	FAILED	\N	\N	(#132012) Parameter format does not match format in the created template	\N	\N	\N	\N	0	3	\N	2025-12-14 09:52:33.435	2025-12-14 09:52:34.6	\N
67337d31-b4aa-40de-9dfa-29de8161f20b	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	1f9b67d9-7628-4e5b-8dc3-dbd205feba6d	+918329842193	WHATSAPP	Grow your business with smarter WhatsApp marketing\nOrbiFlow helps you reach customers instantly using the official WhatsApp Business API.\n\nSend bulk messages, automate follow-ups, and track delivery — all from one powerful dashboard.\n\n✅ Secure & compliant messaging\n✅ Bulk campaigns & templates\n✅ Real-time delivery insights\n✅ Built for scale & reliability	702bac9a-6a8a-4b43-ba5e-6be9ef5c59ae	{}	\N	\N	FAILED	\N	\N	(#132012) Parameter format does not match format in the created template	\N	\N	\N	\N	0	3	\N	2025-12-14 09:52:33.438	2025-12-14 09:52:34.659	\N
9df106af-eb0f-4282-a446-9920beeb6c44	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	ef481f64-6484-4ab0-bb1e-71cc6cc88ab6	+919370902057	WHATSAPP	🙏 *SRPF Command Dashboard* मध्ये आपले स्वागत आहे. \n*कृपया पर्याय निवडा:*	57dff916-ea0a-4e55-8ab2-be6c5a74059e	{}	\N	\N	FAILED	\N	\N	(#138000) Calling API not enabled	\N	\N	\N	\N	0	3	\N	2025-12-14 09:54:35.433	2025-12-14 09:54:36.486	\N
3169a5d6-d8d4-4b67-997f-d7b98c63fc83	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	1f9b67d9-7628-4e5b-8dc3-dbd205feba6d	+918329842193	WHATSAPP	🙏 *SRPF Command Dashboard* मध्ये आपले स्वागत आहे. \n*कृपया पर्याय निवडा:*	57dff916-ea0a-4e55-8ab2-be6c5a74059e	{}	\N	\N	FAILED	\N	\N	(#138000) Calling API not enabled	\N	\N	\N	\N	0	3	\N	2025-12-14 09:54:35.44	2025-12-14 09:54:36.857	\N
b65174aa-21f4-4fda-abed-1d800b69576b	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	ef481f64-6484-4ab0-bb1e-71cc6cc88ab6	+919370902057	WHATSAPP	Hello, Wolcome to the company	7dcee5a4-2c08-4937-bdf1-2c8c47652138	{}	\N	\N	SENT	WHATSAPP_BUSINESS_API	wamid.HBgMOTE5MzcwOTAyMDU3FQIAERgSMDA1ODBBODNGOENFN0Q3RTU1AA==	\N	\N	2025-12-14 09:57:48.459	\N	\N	0	3	\N	2025-12-14 09:57:46.442	2025-12-14 09:57:48.459	\N
7f858a45-a452-47ce-af41-a8a06a24f1b8	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	1f9b67d9-7628-4e5b-8dc3-dbd205feba6d	+918329842193	WHATSAPP	आपले स्वागत आहे 🙏\n*_कृपया पर्याय निवडा:_*	14995dd2-2fb2-49ad-9924-8baa13abc418	{}	\N	\N	SENT	WHATSAPP_BUSINESS_API	wamid.HBgMOTE4MzI5ODQyMTkzFQIAERgSODNENkM3REVDQTlCMzJGNTIzAA==	\N	\N	2025-12-14 09:58:32.109	\N	\N	0	3	\N	2025-12-14 09:58:30.641	2025-12-14 09:58:32.109	\N
3188cb94-025a-42a5-a731-a7ad469bb93f	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	ef481f64-6484-4ab0-bb1e-71cc6cc88ab6	+919370902057	WHATSAPP	आपले स्वागत आहे 🙏\n*_कृपया पर्याय निवडा:_*	14995dd2-2fb2-49ad-9924-8baa13abc418	{}	\N	\N	SENT	WHATSAPP_BUSINESS_API	wamid.HBgMOTE5MzcwOTAyMDU3FQIAERgSNEJCQTg5MTE0NDU2MzdDNTZEAA==	\N	\N	2025-12-14 09:58:32.553	\N	\N	0	3	\N	2025-12-14 09:58:30.545	2025-12-14 09:58:32.553	\N
365dd436-5c27-4836-9ad9-376c38e67a9b	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	1f9b67d9-7628-4e5b-8dc3-dbd205feba6d	+918329842193	WHATSAPP	Welcome and congratulations!! This message demonstrates your ability to send a WhatsApp message notification from the Cloud API, hosted by Meta. Thank you for taking the time to test with us.	25c0f3ff-97ec-49c7-a2e2-90f0180e702e	{}	\N	\N	FAILED	\N	\N	(#131030) Recipient phone number not in allowed list	\N	\N	\N	\N	0	3	\N	2025-12-14 10:28:04.653	2025-12-14 10:28:05.549	\N
397a23c1-ce01-4276-96b4-9bfd67486d70	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	900610c9-dec3-4f44-a32d-d6f09d7b175a	+917517262376	WHATSAPP	Welcome and congratulations!! This message demonstrates your ability to send a WhatsApp message notification from the Cloud API, hosted by Meta. Thank you for taking the time to test with us.	25c0f3ff-97ec-49c7-a2e2-90f0180e702e	{}	\N	\N	SENT	WHATSAPP_BUSINESS_API	wamid.HBgMOTE3NTE3MjYyMzc2FQIAERgSQzE5NTBGMDYyMTc3MDVFMjYxAA==	\N	\N	2025-12-14 10:28:06.221	\N	\N	0	3	\N	2025-12-14 10:28:04.657	2025-12-14 10:28:06.221	\N
25b7ce04-6bd8-43d3-b723-88db3562b568	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	ef481f64-6484-4ab0-bb1e-71cc6cc88ab6	+919370902057	WHATSAPP	Welcome and congratulations!! This message demonstrates your ability to send a WhatsApp message notification from the Cloud API, hosted by Meta. Thank you for taking the time to test with us.	25c0f3ff-97ec-49c7-a2e2-90f0180e702e	{}	\N	\N	SENT	WHATSAPP_BUSINESS_API	wamid.HBgMOTE5MzcwOTAyMDU3FQIAERgSQkJEMzEwRjNCQjMyMUFDOTA4AA==	\N	\N	2025-12-14 10:28:06.45	\N	\N	0	3	\N	2025-12-14 10:28:04.552	2025-12-14 10:28:06.45	\N
02d0c357-35e3-424e-a1f5-eef4e72fc295	babcdaf3-79b3-45f6-afb6-813d833b4bb2	\N	172535da-72ed-4426-82c2-1bee53b34885	+918788209521	WHATSAPP	Welcome and congratulations!! This message demonstrates your ability to send a WhatsApp message notification from the Cloud API, hosted by Meta. Thank you for taking the time to test with us.	25c0f3ff-97ec-49c7-a2e2-90f0180e702e	{}	\N	\N	SENT	WHATSAPP_BUSINESS_API	wamid.HBgMOTE4Nzg4MjA5NTIxFQIAERgSNkQ3RkQyMTgzMDgyN0JFNjk0AA==	\N	\N	2025-12-14 10:28:06.666	\N	\N	0	3	\N	2025-12-14 10:28:04.745	2025-12-14 10:28:06.666	\N
\.


--
-- TOC entry 3742 (class 0 OID 23699)
-- Dependencies: 234
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_methods (id, "tenantId", type, "razorpayPaymentMethodId", last4, brand, "expiryMonth", "expiryYear", "isDefault", "isActive", "billingDetails", metadata, "createdAt", "updatedAt", "deletedAt") FROM stdin;
\.


--
-- TOC entry 3729 (class 0 OID 23379)
-- Dependencies: 221
-- Data for Name: segments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.segments (id, "tenantId", name, description, filters, "contactCount", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3741 (class 0 OID 23687)
-- Dependencies: 233
-- Data for Name: subscribers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscribers (id, "tenantId", email, phone, "firstName", "lastName", status, source, tags, "customFields", "subscribedAt", "unsubscribedAt", "lastEmailSentAt", "emailVerified", "emailVerificationToken", "verifiedAt", "createdAt", "updatedAt", "deletedAt") FROM stdin;
d40d3361-43bc-4b88-9abb-c975ce0801a1	77895778-42f2-46ee-a8b0-188073469be1	Karad74@gmail.com	+919767604234	Sarthakk	Karaad	ACTIVE	manual	{}	{}	2025-11-27 08:07:55.486	\N	\N	f	578c6fd4b7175d518bdace170e6b131044aef106808d5d9f2fe00a456cd5aeab	\N	2025-11-27 08:07:55.488	2025-11-27 08:09:23.183	2025-11-27 08:09:23.181
2a23a59f-945c-4fbd-af24-edf0012efb15	b77305a1-f7ba-4c83-9136-31aa4a94a7d5	dsubscriber1@gmail.com	+914444444444	dsdd	dld	ACTIVE	manual	{vip}	{}	2025-11-28 07:36:54.919	\N	\N	f	3bab15a462166f3eda4fdf106d3e9a16794d46e31d2e40244da014ff5c1e5d09	\N	2025-11-28 07:36:54.923	2025-11-28 07:36:54.923	\N
\.


--
-- TOC entry 3727 (class 0 OID 23358)
-- Dependencies: 219
-- Data for Name: templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.templates (id, "tenantId", name, category, channel, body, variables, language, "isActive", "providerTemplateId", status, "createdAt", "updatedAt", feature, identifier, industry) FROM stdin;
5af660aa-36d8-4295-906d-d320a3c5d30e	27e75113-361e-4f59-9e14-51c1b98c71f4	Welcome Message	MARKETING	WHATSAPP	Hi {{name}}! Welcome to {{company}}. We are excited to have you on board! 🎉	[{"name": "name", "type": "string", "required": true}, {"name": "company", "type": "string", "required": true}]	en	t	\N	APPROVED	2025-11-25 07:56:47.128	2025-11-25 07:56:47.128	\N	\N	\N
c6f7414d-11b2-4af8-8516-f1fc19332064	27e75113-361e-4f59-9e14-51c1b98c71f4	OTP Verification	OTP	SMS	Your OTP for {{service}} is {{otp}}. Valid for {{minutes}} minutes. Do not share this code.	[{"name": "service", "type": "string", "required": true}, {"name": "otp", "type": "string", "required": true}, {"name": "minutes", "type": "number", "required": true}]	en	t	\N	APPROVED	2025-11-25 07:56:47.284	2025-11-25 07:56:47.284	\N	\N	\N
d7c4f9f1-814e-4c65-838e-4e0ba4184d54	27e75113-361e-4f59-9e14-51c1b98c71f4	Order Confirmation	TRANSACTIONAL	EMAIL	Hello {{name}},\n\nYour order #{{orderId}} has been confirmed!\n\nItems: {{items}}\nTotal: ₹{{amount}}\n\nThank you for your purchase!	[{"name": "name", "type": "string", "required": true}, {"name": "orderId", "type": "string", "required": true}, {"name": "items", "type": "string", "required": true}, {"name": "amount", "type": "number", "required": true}]	en	t	\N	APPROVED	2025-11-25 07:56:47.387	2025-11-25 07:56:47.387	\N	\N	\N
8f875799-04d5-4df6-98b6-ee46381c7d23	27e75113-361e-4f59-9e14-51c1b98c71f4	Payment Reminder	ALERT	WHATSAPP	Hi {{name}}, this is a reminder that your payment of ₹{{amount}} for {{service}} is due on {{dueDate}}. Please make the payment to avoid service interruption.	[{"name": "name", "type": "string", "required": true}, {"name": "amount", "type": "number", "required": true}, {"name": "service", "type": "string", "required": true}, {"name": "dueDate", "type": "string", "required": true}]	en	t	\N	APPROVED	2025-11-25 07:56:47.487	2025-11-25 07:56:47.487	\N	\N	\N
77d8d862-7af1-42c4-95e5-d44c6d153a8b	076a4a0a-bc41-49ab-a882-61ac7a4cf201	Order Confirmation	TRANSACTIONAL	SMS	Your order #{{orderId}} has been confirmed! Total: ₹{{amount}}	[{"name": "orderId", "type": "string", "required": true}, {"name": "amount", "type": "number", "required": true}]	en	t	\N	APPROVED	2025-11-25 07:56:48.872	2025-11-25 07:56:48.872	\N	\N	\N
9995868c-ab86-4621-bb42-8d834764dc74	076a4a0a-bc41-49ab-a882-61ac7a4cf201	Welcome Message	MARKETING	WHATSAPP	Hello {{firstName}}, welcome to our service! Your account is now active.	[{"key": "firstName", "type": "string", "required": true}, {"key": "accountId", "type": "string", "required": false}]	en	t	\N	DRAFT	2025-11-26 09:59:47.843	2025-11-26 09:59:47.843	User Onboarding	welcome_msg_001	E-commerce
d1386a05-d5dc-450f-8919-42dc543796e8	076a4a0a-bc41-49ab-a882-61ac7a4cf201	Authentication	AUTHENTICATION	SMS	hello	[]	en	f	\N	DRAFT	2025-11-26 10:58:06.376	2025-11-29 08:12:17.373	Call permissions	\N	E-commerce
5fa7c0ca-206c-40cc-ba48-384b3c6e0782	076a4a0a-bc41-49ab-a882-61ac7a4cf201	Hello Orbi	MARKETING	SMS	Hello, welcome to our service! Your account is now active.	[{"key": "firstName", "type": "string", "required": true}, {"key": "accountId", "type": "string", "required": false}]	en	t	\N	DRAFT	2025-11-26 12:02:31.527	2025-11-26 12:02:31.527	User Onboarding	welcome_msg_001	E-commerce
6984aa40-72d7-4c86-b3a6-b91974ee24a1	076a4a0a-bc41-49ab-a882-61ac7a4cf201	Offer	MARKETING	WHATSAPP	Hello, welcome to our service! Your account is now active.	[{"key": "firstName", "type": "string", "required": true}, {"key": "accountId", "type": "string", "required": false}]	en	t	\N	APPROVED	2025-11-26 11:13:57.083	2025-12-12 10:08:20.799	User Onboarding	welcome_msg_001	E-commerce
577fa883-198d-4222-bc8a-41f7a140d03e	076a4a0a-bc41-49ab-a882-61ac7a4cf201	testing	UTILITY	WHATSAPP	testing 101	[]	en	t	\N	APPROVED	2025-12-13 11:14:24.648	2025-12-13 11:14:34.149	\N	\N	\N
25c0f3ff-97ec-49c7-a2e2-90f0180e702e	babcdaf3-79b3-45f6-afb6-813d833b4bb2	hello_world	UTILITY	WHATSAPP	Welcome and congratulations!! This message demonstrates your ability to send a WhatsApp message notification from the Cloud API, hosted by Meta. Thank you for taking the time to test with us.	\N	en_US	t	24642117088776965	APPROVED	2025-12-14 07:30:11.536	2025-12-14 07:30:11.536	\N	\N	\N
702bac9a-6a8a-4b43-ba5e-6be9ef5c59ae	babcdaf3-79b3-45f6-afb6-813d833b4bb2	orbi_welcome	MARKETING	WHATSAPP	Grow your business with smarter WhatsApp marketing\nOrbiFlow helps you reach customers instantly using the official WhatsApp Business API.\n\nSend bulk messages, automate follow-ups, and track delivery — all from one powerful dashboard.\n\n✅ Secure & compliant messaging\n✅ Bulk campaigns & templates\n✅ Real-time delivery insights\n✅ Built for scale & reliability	\N	en	t	737672252683280	APPROVED	2025-12-14 07:30:11.535	2025-12-14 07:30:11.535	\N	\N	\N
b33a1b7b-3a13-4d28-8390-86180cae654e	babcdaf3-79b3-45f6-afb6-813d833b4bb2	appointment_completion	UTILITY	WHATSAPP	📋 भेट तपशील:\nप्रकार: {{var1}}\nतारीख: {{var2}}\nवेळ: {{var3}}\nस्थिती: पूर्ण झाली\n\n👤 आपले तपशील:\nनाव: {{var4}}\nबॅज क्र.: {{var5}}\n\n{{var6}}\n\nधन्यवाद!	[{"name": "var1", "type": "text", "required": false}, {"name": "var2", "type": "text", "required": false}, {"name": "var3", "type": "text", "required": false}, {"name": "var4", "type": "text", "required": false}, {"name": "var5", "type": "text", "required": false}, {"name": "var6", "type": "text", "required": false}]	mr	t	548588528349699	APPROVED	2025-12-14 07:30:11.536	2025-12-14 07:30:11.536	\N	\N	\N
887ae648-76b2-4bd5-8300-e423296d02f4	babcdaf3-79b3-45f6-afb6-813d833b4bb2	appointment_completion_notification	UTILITY	WHATSAPP	📋 भेट तपशील:\nप्रकार: {{var1}}\nतारीख: {{var2}}\nवेळ: {{var3}}\nस्थिती: पूर्ण झाली\n\n👤 आपले तपशील:\nनाव: {{var4}}\nबॅज क्र.: {{var5}}\n\n{{var6}}\n\nधन्यवाद!	[{"name": "var1", "type": "text", "required": false}, {"name": "var2", "type": "text", "required": false}, {"name": "var3", "type": "text", "required": false}, {"name": "var4", "type": "text", "required": false}, {"name": "var5", "type": "text", "required": false}, {"name": "var6", "type": "text", "required": false}]	en	t	2700262873641014	APPROVED	2025-12-14 07:30:11.536	2025-12-14 07:30:11.536	\N	\N	\N
941f3d7b-a1f3-4f95-be81-66bf50c35114	babcdaf3-79b3-45f6-afb6-813d833b4bb2	delivery_status	UTILITY	WHATSAPP	Hello {{var1}}, your order {{var2}} is out for delivery	[{"name": "var1", "type": "text", "required": false}, {"name": "var2", "type": "text", "required": false}]	en_US	t	1636457804185331	REJECTED	2025-12-14 07:30:11.535	2025-12-14 07:30:11.535	\N	\N	\N
14995dd2-2fb2-49ad-9924-8baa13abc418	babcdaf3-79b3-45f6-afb6-813d833b4bb2	srpf_whatsapp_dashboard	MARKETING	WHATSAPP	आपले स्वागत आहे 🙏\n*_कृपया पर्याय निवडा:_*	\N	mr	t	1980673336025917	APPROVED	2025-12-14 07:30:11.574	2025-12-14 07:30:11.574	\N	\N	\N
7dcee5a4-2c08-4937-bdf1-2c8c47652138	babcdaf3-79b3-45f6-afb6-813d833b4bb2	welcome_text	MARKETING	WHATSAPP	Hello, Wolcome to the company	\N	en_US	t	2347226335699017	APPROVED	2025-12-14 07:30:11.574	2025-12-14 07:30:11.574	\N	\N	\N
57dff916-ea0a-4e55-8ab2-be6c5a74059e	babcdaf3-79b3-45f6-afb6-813d833b4bb2	srpf	MARKETING	WHATSAPP	🙏 *SRPF Command Dashboard* मध्ये आपले स्वागत आहे. \n*कृपया पर्याय निवडा:*	\N	mr	t	1722861135047740	APPROVED	2025-12-14 07:30:11.574	2025-12-14 07:30:11.574	\N	\N	\N
cb86492c-799c-41c6-a249-e75f4b6279a0	babcdaf3-79b3-45f6-afb6-813d833b4bb2	order_confirmation	UTILITY	WHATSAPP	Hi {{var1}}, your order {{var2}} has been confirmed. We will notify you once it is shipped.	[{"name": "var1", "type": "text", "required": false}, {"name": "var2", "type": "text", "required": false}]	en_US	t	25157343313936983	REJECTED	2025-12-14 07:30:11.574	2025-12-14 07:30:11.574	\N	\N	\N
bce7f1f1-e5df-4d8b-9f45-fc5643f69b20	babcdaf3-79b3-45f6-afb6-813d833b4bb2	order_confirmation_2	UTILITY	WHATSAPP	Hi, your order has been confirmed. We will notify you once it is shipped.	\N	en_US	t	1656662288632762	APPROVED	2025-12-14 07:30:11.574	2025-12-14 07:30:11.574	\N	\N	\N
fb226ace-c98b-402d-be62-3a0f91e299b1	babcdaf3-79b3-45f6-afb6-813d833b4bb2	good_morning_message	MARKETING	WHATSAPP	नमस्कार {{var1}},\nआपला दिवस आनंदी आणि उत्साही जावो हीच शुभेच्छा! ✨	[{"name": "var1", "type": "text", "required": false}]	mr	t	889726773542522	APPROVED	2025-12-14 07:30:11.626	2025-12-14 07:30:11.626	\N	\N	\N
b7066c88-f9e6-4e04-b47c-70288b7f83de	babcdaf3-79b3-45f6-afb6-813d833b4bb2	salary_slip_notification	UTILITY	WHATSAPP	नमस्कार 🙏\n\n*_{{var1}}_*  महिन्याची वेतन पावती आता उपलब्ध करण्यात आली आहे.  \nआपण आपल्या वेतन पावतीचे विवरण पाहू शकता.	[{"name": "var1", "type": "text", "required": false}]	mr	t	1382276173300615	APPROVED	2025-12-14 07:30:11.626	2025-12-14 07:30:11.626	\N	\N	\N
\.


--
-- TOC entry 3744 (class 0 OID 23758)
-- Dependencies: 236
-- Data for Name: tenant_meta_credentials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_meta_credentials (id, "tenantId", "appId", "appSecret", "accessToken", "phoneNumberId", "wabaId", "webhookVerifyToken", "apiVersion", "apiBaseUrl", "webhookUrl", "isActive", "createdAt", "updatedAt", "webhookSecret") FROM stdin;
32a26bff-f68e-4680-93ea-e02ad264db99	babcdaf3-79b3-45f6-afb6-813d833b4bb2	800805298966315	ff515c22a53e713bf216f54d6521cba1	EAALYVANhDysBQLnZC4iWbWBGXtsRWZBn9yuYZABLujZCY2nYdNzgSkYXCZC6yiha79W5qvA2zcZAbFeqleBKktZCBg0huzcdjlLpOjG3FUNZCWAJC57XQipqZAHjgOh0Sy4sXaAgJU48BQZBPLd1NqW9kZB3BTMuX08Vpav7XCf3dUioff7FSz7S8nWp38rqyH7jnBwIlZBAZA6zShHZCPKzYTQZAUdh8ZBuAfdrXBJSN8HTYL6ZCFoiH9tmcZCVALNeYFmFNmBvK48i3CNFy1Lu1PAfN5ZBAa5DagecFPSx4zT2Jvb8QZDZD	800933146437136	979360274322321	mTKbjf1ykxbGi3cnZkjUguM6XJSzABal	v23.0	https://graph.facebook.com	https://orbiflow.navantra.in/whatsapp/webhook	t	2025-12-14 07:25:25.227	2025-12-14 10:30:23.548	mTKbjf1ykxbGi3cnZkjUguM6XJSzABal
\.


--
-- TOC entry 3724 (class 0 OID 23323)
-- Dependencies: 216
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenants (id, slug, name, subdomain, "customDomain", logo, "brandColors", status, plan, "razorpayCustomerId", "razorpaySubscriptionId", "trialEndsAt", "subscriptionStartsAt", "subscriptionEndsAt", "messageQuota", "messageUsed", "quotaResetAt", features, "createdAt", "updatedAt", "deletedAt", "emailSettings", "whatsappSettings") FROM stdin;
dc57f39a-4a2c-45ae-a05f-d0063e65753d	policy	Corp	policy.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 12:15:48.989	\N	\N	1000	0	2025-11-28 12:15:48.99	\N	2025-11-28 12:15:48.99	2025-11-28 12:15:48.99	\N	\N	\N
27e75113-361e-4f59-9e14-51c1b98c71f4	platform	Orbi Platform	platform.orbi.in	\N	\N	\N	ACTIVE	ENTERPRISE	\N	\N	\N	\N	\N	1000000	0	2025-11-25 07:56:45.921	{"sms": true, "email": true, "whatsapp": true, "analytics": true, "workflows": true}	2025-11-25 07:56:45.921	2025-11-25 07:56:45.921	\N	\N	\N
ed4511d7-f4e1-4c87-8fda-4423a3dd7086	admin	Corp	admin.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 12:17:51.888	\N	\N	1000	0	2025-11-28 12:17:51.889	\N	2025-11-28 12:17:51.889	2025-11-28 12:17:51.889	\N	\N	\N
979b54d4-ac7d-4832-aa67-a406744916cf	super	Corp	super.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 12:21:36.235	\N	\N	1000	0	2025-11-28 12:21:36.237	\N	2025-11-28 12:21:36.237	2025-11-28 12:21:36.237	\N	\N	\N
8cfed6c0-0185-4828-956b-12b2be93aab0	type	Corp	type.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 14:08:55.352	\N	\N	1000	0	2025-11-28 14:08:55.356	\N	2025-11-28 14:08:55.356	2025-11-28 14:08:55.356	\N	\N	\N
77895778-42f2-46ee-a8b0-188073469be1	abc	 Corp	abc.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-10 15:39:50.831	\N	\N	1000	0	2025-11-26 15:39:50.839	\N	2025-11-26 15:39:50.839	2025-11-26 15:39:50.839	\N	\N	\N
b77305a1-f7ba-4c83-9136-31aa4a94a7d5	ddslug	Navantra	ddslug.orbi.in	\N	\N	\N	TRIAL	ENTERPRISE	\N	\N	2025-12-11 06:17:16.023	\N	\N	1000	0	2025-11-30 18:30:00	\N	2025-11-27 05:49:05.478	2025-11-27 12:19:51.192	\N	\N	\N
485cfaad-be09-4ad2-863c-ea8508e3ca68	poi	 Corp	poi.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 05:49:18.527	\N	\N	1000	0	2025-11-28 05:49:18.528	\N	2025-11-28 05:49:18.528	2025-11-28 05:49:18.528	\N	\N	\N
223de0a1-55ee-4d84-aafb-04093592e104	powerr	 Corp	powerr.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 06:07:04.542	\N	\N	1000	0	2025-11-28 06:07:04.546	\N	2025-11-28 06:07:04.546	2025-11-28 06:07:04.546	\N	\N	\N
b40fd8af-ad50-427c-a484-f71bc3a935cd	catch	Corp	catch.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 10:39:03.911	\N	\N	1000	0	2025-11-28 10:39:03.916	\N	2025-11-28 10:39:03.916	2025-11-28 10:39:03.916	\N	\N	\N
bffd7e54-f74d-44b0-a5cf-cffc564767e6	sip	Corp	sip.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-12 10:52:21.901	\N	\N	1000	0	2025-11-28 10:52:21.903	\N	2025-11-28 10:52:21.903	2025-11-28 10:52:21.903	\N	\N	\N
54a95a3b-0668-4742-97ec-6c4c37212da2	tryy	Corp	tryy.orbi.in	\N	\N	\N	CANCELED	FREE	\N	\N	2025-12-12 06:48:47.339	\N	\N	1000	0	2025-11-28 06:48:47.346	\N	2025-11-28 06:48:47.346	2025-12-13 06:54:26.365	2025-12-13 06:54:26.364	\N	\N
c36f7dda-c75e-496c-aa4f-04a2fe42b952	test2slug	test2	test2slug.orbi.in	\N	\N	\N	CANCELED	STARTER	\N	\N	2025-12-27 07:10:28.545	\N	\N	1000	0	2025-12-13 07:04:09.466	\N	2025-12-13 07:04:09.466	2025-12-13 09:21:51.542	2025-12-13 09:21:51.541	\N	\N
9f86fc46-b2ee-4b4c-a61b-9b7c076eca3b	test1slug	test1	test1slug.orbi.in	\N	\N	\N	CANCELED	FREE	\N	\N	2025-12-27 07:02:46.168	\N	\N	1000	0	2025-12-13 07:02:46.272	\N	2025-12-13 07:02:46.272	2025-12-13 09:22:00.748	2025-12-13 09:22:00.746	\N	\N
71b8224c-8b57-4c92-a454-c55597c2cb94	srpf	SRPF	srpf.orbi.in	\N	\N	\N	CANCELED	FREE	\N	\N	2025-12-11 08:05:16.346	\N	\N	1000	0	2025-11-27 08:05:16.348	\N	2025-11-27 08:05:16.348	2025-12-14 06:30:07.482	2025-12-14 06:30:07.481	\N	\N
36df4c98-9a7d-4d7b-bc2a-53307a78dc01	abefgcdf	 Corp	abefgcdf.orbi.in	\N	\N	\N	CANCELED	FREE	\N	\N	2025-12-11 08:05:37.712	\N	\N	1000	0	2025-11-27 08:05:37.714	\N	2025-11-27 08:05:37.714	2025-12-14 06:30:12.677	2025-12-14 06:30:12.677	\N	\N
076a4a0a-bc41-49ab-a882-61ac7a4cf201	demo	Demo Company	demo.orbi.in	\N	\N	\N	CANCELED	PROFESSIONAL	\N	\N	\N	\N	\N	100000	0	2025-11-25 07:56:46.627	{"sms": true, "email": true, "whatsapp": true, "analytics": true, "workflows": true}	2025-11-25 07:56:46.627	2025-12-14 06:30:17.547	2025-12-14 06:30:17.545	\N	\N
7149a071-2252-42a5-86a5-bd3ccc9d58a1	abcdf	 Corp	abcdf.orbi.in	\N	\N	\N	CANCELED	FREE	\N	\N	2025-12-11 07:59:51.154	\N	\N	1000	0	2025-11-27 07:59:51.158	\N	2025-11-27 07:59:51.158	2025-12-14 06:30:21.599	2025-12-14 06:30:21.598	\N	\N
33dfbf9c-a10d-4b46-abea-555086f41af6	acmee	Acme Corp	acmee.orbi.in	\N	\N	\N	CANCELED	FREE	\N	\N	2025-12-25 04:58:34.636	\N	\N	1000	0	2025-12-11 04:58:34.64	\N	2025-12-11 04:58:34.64	2025-12-14 06:30:31.274	2025-12-14 06:30:31.273	\N	\N
45f915e6-26dd-4997-9e9a-b7cc246e50e3	acme	Acme Corp	acme.orbi.in	\N	\N	\N	CANCELED	FREE	\N	\N	2025-12-12 16:13:21.08	\N	\N	1000	0	2025-12-31 18:30:00	\N	2025-11-28 16:13:21.083	2025-12-14 06:30:34.871	2025-12-14 06:30:34.781	\N	\N
859f3f46-19f5-44c5-9b23-7787064d4ade	test	test	test.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-28 07:06:53.425	\N	\N	1000	0	2025-12-14 07:06:53.444	\N	2025-12-14 07:06:53.444	2025-12-14 07:06:53.444	\N	\N	\N
babcdaf3-79b3-45f6-afb6-813d833b4bb2	adi	aditya	adi.orbi.in	\N	\N	\N	TRIAL	FREE	\N	\N	2025-12-28 07:17:21.323	\N	\N	1000	6	2025-12-31 18:30:00	\N	2025-12-14 07:17:21.342	2025-12-14 10:28:06.668	\N	\N	\N
\.


--
-- TOC entry 3725 (class 0 OID 23336)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, "tenantId", email, password, "firstName", "lastName", phone, avatar, role, "isActive", "lastLoginAt", "twoFactorEnabled", "twoFactorSecret", "createdAt", "updatedAt", "deletedAt") FROM stdin;
a6b7b8cb-eda6-4025-8d70-118f6ee8fd4b	bffd7e54-f74d-44b0-a5cf-cffc564767e6	demo98@gmail.com	$2a$10$up4WBan82VTGjTbe.HgQ.OjW4MBirPUQGlz3N59NVWIaXpCAlNdCG	Corp	\N	+917485967485	\N	ADMIN	t	\N	f	\N	2025-11-28 10:52:22.082	2025-11-28 10:52:22.082	\N
5cc76438-1691-4e69-b17f-c69a2e05f724	7149a071-2252-42a5-86a5-bd3ccc9d58a1	sarthak@gmail.com	$2a$10$CvSMv7eV5lA38lu3vZkwauZPXWRoPp.1yGEjsgeVeiqBjwcHBYAMO		Corp	3234567890	\N	ADMIN	t	2025-11-28 10:52:53.149	f	\N	2025-11-27 07:59:51.368	2025-11-28 10:52:53.15	\N
204dc130-ecaf-4612-b800-a2e65622e0cc	dc57f39a-4a2c-45ae-a05f-d0063e65753d	demo88@gmail.com	$2a$10$CvetOCeu/I5MSN/FpBE0.ekBjJ0e3wgH2aeYyJotwXbXXIw4esWa2	Corp	\N	+911234567891	\N	ADMIN	t	\N	f	\N	2025-11-28 12:15:49.15	2025-11-28 12:15:49.15	\N
be74de6a-ea62-45b4-9b0b-918c9a1cdc58	ed4511d7-f4e1-4c87-8fda-4423a3dd7086	try@gmail.com	$2a$10$eFv411I3xQs7doE.DPN/IuFS4i5Q4KE2mBw2TF.ratwRZlexFaFTm	Corp	\N	+911234567892	\N	ADMIN	t	\N	f	\N	2025-11-28 12:17:51.994	2025-11-28 12:17:51.994	\N
d41f6874-c26e-4d5e-ad50-710c0cbbbd58	979b54d4-ac7d-4832-aa67-a406744916cf	try1@gmail.com	$2a$10$oOiFGRI1Rn/giEFjMUYiw.EWCClcd73Lb9749Ua28tYHmCIZ0tVgK	Corp	\N	+912536142541	\N	ADMIN	t	\N	f	\N	2025-11-28 12:21:36.386	2025-11-28 12:21:36.386	\N
958a95bf-716a-4290-9791-1fbdfce3ef2e	b77305a1-f7ba-4c83-9136-31aa4a94a7d5	dilipdake92@gmail.com	$2a$10$ii6VLiLbUBmIUHRFeKjOiOWbxatUpgwlUj0qbhItiFKYD61RVQ2uS	Navantra	Company	919637057318	\N	ADMIN	t	2025-11-27 06:17:50.896	f	\N	2025-11-27 05:49:05.627	2025-11-27 06:25:47.822	\N
9ab2c647-5ace-4805-ba62-50f68788a144	8cfed6c0-0185-4828-956b-12b2be93aab0	try2@gmail.com	$2a$10$SSQtJO4TpL/WhHjjAmiSdOFJLByCLr/BIXJ5dluvKoSTN0hb.zg4u	Corp	\N	+917418529631	\N	ADMIN	t	\N	f	\N	2025-11-28 14:08:55.578	2025-11-28 14:08:55.578	\N
318d0a14-77c7-4dd3-8fe6-ae93760b2568	b77305a1-f7ba-4c83-9136-31aa4a94a7d5	duser1@gmail.com	$2a$10$TXteLx3Fo.s6B/2gO9gqbOsOfrdbmaWKuYsTjlOMP81ikejHupXP6	duser1	d1	+918989898989	\N	MEMBER	t	\N	f	\N	2025-11-27 06:43:37.083	2025-11-27 06:43:37.083	\N
995cc4ac-2b4c-4071-91ec-116b573a2c31	223de0a1-55ee-4d84-aafb-04093592e104	sarthakk@gmail.com	$2a$10$o.WvKMczpptqtpyLBinKxugOavIYnpdUPZL7ILaVuysiGRLg1sjCG		Corp	3234567890	\N	ADMIN	t	\N	f	\N	2025-11-28 06:07:04.712	2025-11-28 06:07:04.712	\N
7040da56-58cf-4fb4-beff-3d75cf3b0264	36df4c98-9a7d-4d7b-bc2a-53307a78dc01	sarthak@gmail.com	$2a$10$2W2HR9l0jqccbYE8VirjAeK.xwfHjtzHuPXAR0omv/sBKM2j1PWBu		Corp	3234567890	\N	ADMIN	t	2025-11-28 06:07:21.839	f	\N	2025-11-27 08:05:37.867	2025-11-28 06:07:21.843	\N
f77c064c-0e3f-4f4e-afbe-43d49392f71c	54a95a3b-0668-4742-97ec-6c4c37212da2	sarthak.k@gmail.com	$2a$10$YmNk8d93s8k4OUNSn.LB0.kgaf2icPd6A7dwDsEcFxpf8BmfnU9AO	Corp	\N	+913234567890	\N	ADMIN	t	\N	f	\N	2025-11-28 06:48:47.522	2025-11-28 06:48:47.522	\N
a2536edf-41e8-4826-a494-42c4571f8d5b	77895778-42f2-46ee-a8b0-188073469be1	sarthak@gmail.com	$2a$10$4sR589RKdhDzgCrC7.6pIuE/tasAwX1fA0N.KWMQCV9MCJ5BEXJI6		Corp	3234567890	\N	ADMIN	t	2025-11-28 06:49:06.173	f	\N	2025-11-26 15:39:51.02	2025-11-28 06:49:06.18	\N
32e566e5-7712-4320-92a5-7be0163c748e	b40fd8af-ad50-427c-a484-f71bc3a935cd	karad98@gmail.com	$2a$10$DhQqNdvD3SXxsqdmZ9zjnOYxA7QH5YSSCs3RMrnMpZ.736PC1kYXW	Corp	\N	+919685749685	\N	ADMIN	t	\N	f	\N	2025-11-28 10:39:04.092	2025-11-28 10:39:04.092	\N
1c41b2da-0cc0-4782-b659-6df164ba6b54	485cfaad-be09-4ad2-863c-ea8508e3ca68	sarthak@gmail.com	$2a$10$jArZIKqqZ0ODVzHbSxPaIeXisDYmET4y/1t340Ei14YYqQnmkRRXu		Corp	3234567890	\N	ADMIN	t	2025-11-28 10:39:33.203	f	\N	2025-11-28 05:49:20.103	2025-11-28 10:39:33.204	\N
0dbd342d-7ab5-4d10-81dd-501c0fdffb24	45f915e6-26dd-4997-9e9a-b7cc246e50e3	admin@acme.com	$2a$10$4v8zntvDoLfPYpnzq12Tj.IftGA0Dp2zmIyzFaIl/6s5XBE7m5cri	Acme	Corp	+919850108286	\N	ADMIN	t	2025-12-11 04:58:51.84	f	\N	2025-11-28 16:13:21.272	2025-12-11 04:58:51.841	\N
fa8f25ee-b0b6-4baa-8c2e-f774154b047d	71b8224c-8b57-4c92-a454-c55597c2cb94	srpfpunegroup1@navantra.in	$2a$10$nSI0OXAmOxlfMSJyr9FEz.eThatTlnCsE.seASxFwLZUI2VbQY.ii	SRPF	\N		\N	ADMIN	t	2025-12-11 22:41:25.796	f	\N	2025-11-27 08:05:16.353	2025-12-11 22:41:25.797	\N
3c214ed2-bcc6-4ec1-9f50-d9a13c304b5a	9f86fc46-b2ee-4b4c-a61b-9b7c076eca3b	test1@gmail.com	$2a$10$0B8Q3bSfo6v7GjEweaA5LOkcreep5uiFWfLZOBo2XE95QOCVjvXJ.	test1	\N	+919999999999	\N	ADMIN	t	\N	f	\N	2025-12-13 07:02:46.279	2025-12-13 07:02:46.279	\N
ce1b22a2-76ef-416d-b4d7-e4ba364dd99f	c36f7dda-c75e-496c-aa4f-04a2fe42b952	test2@gmail.com	$2a$10$iTa17Yef6OPrWDq0rkSIRui80W7LTQ5t.KP.uk8oHYa84Fu0gqluS	test2	\N	+913333333333	\N	ADMIN	t	\N	f	\N	2025-12-13 07:04:09.47	2025-12-13 07:04:09.47	\N
1a1fd3f8-e8d2-410e-8c04-661d229a746b	33dfbf9c-a10d-4b46-abea-555086f41af6	admin@acme.com	$2a$10$EPVe34imk7Go1vuy/yHQBuyh2sdmNDZotjxg3fEKxa1qplqK.VtKy	Acme	Corp	9850108286	\N	ADMIN	t	\N	f	\N	2025-12-11 04:58:34.824	2025-12-11 04:58:34.824	\N
ac7ec433-253a-413a-88cf-9484a288d337	076a4a0a-bc41-49ab-a882-61ac7a4cf201	admin@demo.com	$2a$10$NU9wbmLg.w9vO0l4n2EAe.dNrQz6di5HjlSvZLDEidBGjD1odK2W2	Demo	Admin	\N	\N	ADMIN	t	2025-12-14 07:37:19.399	f	\N	2025-11-25 07:56:46.788	2025-12-14 07:37:19.404	\N
17c9fba2-d38f-4ac5-823b-078319147779	859f3f46-19f5-44c5-9b23-7787064d4ade	test@example.com	$2a$10$v6.fZeQXmcwse8gqfgzg2.sB2Ctp6ON1.i8DfS/.F6tQhnrDWF3WC	test	\N	\N	\N	ADMIN	t	\N	f	\N	2025-12-14 07:06:53.474	2025-12-14 07:06:53.474	\N
631db14f-d8a1-468d-aa6d-35008ba45a74	babcdaf3-79b3-45f6-afb6-813d833b4bb2	admin1@admin.com	$2a$10$nSI0OXAmOxlfMSJyr9FEz.eThatTlnCsE.seASxFwLZUI2VbQY.ii	aditya	\N	+91919370902057	\N	ADMIN	t	2025-12-14 07:30:01.54	f	\N	2025-12-14 07:17:21.378	2025-12-14 07:30:01.541	\N
26116f83-ccb4-405d-9d33-b5e45937d269	27e75113-361e-4f59-9e14-51c1b98c71f4	superadmin@orbi.in	$2a$10$6CLDPRJ79ii1je0r.hc3oeeCM07FVu1oza8eDaE7YSE7fagmxe7xm	Super	Admin	\N	\N	SUPER_ADMIN	t	2025-12-14 09:52:01.639	f	\N	2025-11-25 07:56:46.149	2025-12-14 09:52:01.64	\N
\.


--
-- TOC entry 3743 (class 0 OID 23709)
-- Dependencies: 235
-- Data for Name: waba_connections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.waba_connections (id, "userId", "tenantId", "accessToken", "refreshToken", "tokenExpiresAt", "businessId", "businessName", "wabaId", "wabaName", "phoneNumbers", "isActive", "connectedAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3736 (class 0 OID 23445)
-- Dependencies: 228
-- Data for Name: workflow_runs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_runs (id, "workflowId", "tenantId", "userId", "contactId", "triggerType", "triggerData", status, "currentNodeId", error, "startedAt", "completedAt") FROM stdin;
\.


--
-- TOC entry 3735 (class 0 OID 23434)
-- Dependencies: 227
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflows (id, "tenantId", name, description, flow, "isActive", "isPaused", "runsCount", "lastRunAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 3439 (class 2606 OID 23196)
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3515 (class 2606 OID 23475)
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- TOC entry 3519 (class 2606 OID 23483)
-- Name: api_logs api_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_logs
    ADD CONSTRAINT api_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 3523 (class 2606 OID 23491)
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 3498 (class 2606 OID 23433)
-- Name: broadcast_messages broadcast_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcast_messages
    ADD CONSTRAINT broadcast_messages_pkey PRIMARY KEY (id);


--
-- TOC entry 3492 (class 2606 OID 23426)
-- Name: broadcasts broadcasts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT broadcasts_pkey PRIMARY KEY (id);


--
-- TOC entry 3481 (class 2606 OID 23394)
-- Name: contact_segments contact_segments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_segments
    ADD CONSTRAINT contact_segments_pkey PRIMARY KEY ("contactId", "segmentId");


--
-- TOC entry 3471 (class 2606 OID 23378)
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- TOC entry 3489 (class 2606 OID 23413)
-- Name: conversation_assignments conversation_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_assignments
    ADD CONSTRAINT conversation_assignments_pkey PRIMARY KEY (id);


--
-- TOC entry 3483 (class 2606 OID 23405)
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- TOC entry 3508 (class 2606 OID 23463)
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 3456 (class 2606 OID 23357)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- TOC entry 3535 (class 2606 OID 23708)
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- TOC entry 3478 (class 2606 OID 23387)
-- Name: segments segments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.segments
    ADD CONSTRAINT segments_pkey PRIMARY KEY (id);


--
-- TOC entry 3529 (class 2606 OID 23698)
-- Name: subscribers subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribers
    ADD CONSTRAINT subscribers_pkey PRIMARY KEY (id);


--
-- TOC entry 3463 (class 2606 OID 23368)
-- Name: templates templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_pkey PRIMARY KEY (id);


--
-- TOC entry 3547 (class 2606 OID 23768)
-- Name: tenant_meta_credentials tenant_meta_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_meta_credentials
    ADD CONSTRAINT tenant_meta_credentials_pkey PRIMARY KEY (id);


--
-- TOC entry 3442 (class 2606 OID 23335)
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- TOC entry 3450 (class 2606 OID 23346)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3541 (class 2606 OID 23717)
-- Name: waba_connections waba_connections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.waba_connections
    ADD CONSTRAINT waba_connections_pkey PRIMARY KEY (id);


--
-- TOC entry 3503 (class 2606 OID 23453)
-- Name: workflow_runs workflow_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_runs
    ADD CONSTRAINT workflow_runs_pkey PRIMARY KEY (id);


--
-- TOC entry 3500 (class 2606 OID 23444)
-- Name: workflows workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflows_pkey PRIMARY KEY (id);


--
-- TOC entry 3512 (class 1259 OID 23532)
-- Name: api_keys_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_keys_key_idx ON public.api_keys USING btree (key);


--
-- TOC entry 3513 (class 1259 OID 23530)
-- Name: api_keys_key_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX api_keys_key_key ON public.api_keys USING btree (key);


--
-- TOC entry 3516 (class 1259 OID 23531)
-- Name: api_keys_tenantId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "api_keys_tenantId_idx" ON public.api_keys USING btree ("tenantId");


--
-- TOC entry 3517 (class 1259 OID 23533)
-- Name: api_logs_apiKeyId_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "api_logs_apiKeyId_timestamp_idx" ON public.api_logs USING btree ("apiKeyId", "timestamp");


--
-- TOC entry 3520 (class 1259 OID 23534)
-- Name: api_logs_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_logs_timestamp_idx ON public.api_logs USING btree ("timestamp");


--
-- TOC entry 3521 (class 1259 OID 23537)
-- Name: audit_logs_action_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX audit_logs_action_timestamp_idx ON public.audit_logs USING btree (action, "timestamp");


--
-- TOC entry 3524 (class 1259 OID 23535)
-- Name: audit_logs_tenantId_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "audit_logs_tenantId_timestamp_idx" ON public.audit_logs USING btree ("tenantId", "timestamp");


--
-- TOC entry 3525 (class 1259 OID 23536)
-- Name: audit_logs_userId_timestamp_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "audit_logs_userId_timestamp_idx" ON public.audit_logs USING btree ("userId", "timestamp");


--
-- TOC entry 3495 (class 1259 OID 23522)
-- Name: broadcast_messages_broadcastId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "broadcast_messages_broadcastId_idx" ON public.broadcast_messages USING btree ("broadcastId");


--
-- TOC entry 3496 (class 1259 OID 23521)
-- Name: broadcast_messages_messageId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "broadcast_messages_messageId_key" ON public.broadcast_messages USING btree ("messageId");


--
-- TOC entry 3493 (class 1259 OID 23520)
-- Name: broadcasts_tenantId_scheduledAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "broadcasts_tenantId_scheduledAt_idx" ON public.broadcasts USING btree ("tenantId", "scheduledAt");


--
-- TOC entry 3494 (class 1259 OID 23519)
-- Name: broadcasts_tenantId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "broadcasts_tenantId_status_idx" ON public.broadcasts USING btree ("tenantId", status);


--
-- TOC entry 3472 (class 1259 OID 23509)
-- Name: contacts_tenantId_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "contacts_tenantId_email_idx" ON public.contacts USING btree ("tenantId", email);


--
-- TOC entry 3473 (class 1259 OID 23512)
-- Name: contacts_tenantId_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "contacts_tenantId_email_key" ON public.contacts USING btree ("tenantId", email);


--
-- TOC entry 3474 (class 1259 OID 23508)
-- Name: contacts_tenantId_phone_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "contacts_tenantId_phone_idx" ON public.contacts USING btree ("tenantId", phone);


--
-- TOC entry 3475 (class 1259 OID 23511)
-- Name: contacts_tenantId_phone_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "contacts_tenantId_phone_key" ON public.contacts USING btree ("tenantId", phone);


--
-- TOC entry 3476 (class 1259 OID 23510)
-- Name: contacts_tenantId_tags_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "contacts_tenantId_tags_idx" ON public.contacts USING btree ("tenantId", tags);


--
-- TOC entry 3487 (class 1259 OID 23517)
-- Name: conversation_assignments_conversationId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "conversation_assignments_conversationId_idx" ON public.conversation_assignments USING btree ("conversationId");


--
-- TOC entry 3490 (class 1259 OID 23518)
-- Name: conversation_assignments_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "conversation_assignments_userId_idx" ON public.conversation_assignments USING btree ("userId");


--
-- TOC entry 3484 (class 1259 OID 23515)
-- Name: conversations_tenantId_contactId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "conversations_tenantId_contactId_idx" ON public.conversations USING btree ("tenantId", "contactId");


--
-- TOC entry 3485 (class 1259 OID 23516)
-- Name: conversations_tenantId_lastMessageAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "conversations_tenantId_lastMessageAt_idx" ON public.conversations USING btree ("tenantId", "lastMessageAt");


--
-- TOC entry 3486 (class 1259 OID 23514)
-- Name: conversations_tenantId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "conversations_tenantId_status_idx" ON public.conversations USING btree ("tenantId", status);


--
-- TOC entry 3506 (class 1259 OID 23527)
-- Name: invoices_invoiceNumber_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "invoices_invoiceNumber_key" ON public.invoices USING btree ("invoiceNumber");


--
-- TOC entry 3509 (class 1259 OID 23529)
-- Name: invoices_razorpayInvoiceId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "invoices_razorpayInvoiceId_idx" ON public.invoices USING btree ("razorpayInvoiceId");


--
-- TOC entry 3510 (class 1259 OID 23526)
-- Name: invoices_razorpayInvoiceId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "invoices_razorpayInvoiceId_key" ON public.invoices USING btree ("razorpayInvoiceId");


--
-- TOC entry 3511 (class 1259 OID 23528)
-- Name: invoices_tenantId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "invoices_tenantId_status_idx" ON public.invoices USING btree ("tenantId", status);


--
-- TOC entry 3454 (class 1259 OID 23504)
-- Name: messages_conversationId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "messages_conversationId_idx" ON public.messages USING btree ("conversationId");


--
-- TOC entry 3457 (class 1259 OID 23505)
-- Name: messages_providerMessageId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "messages_providerMessageId_idx" ON public.messages USING btree ("providerMessageId");


--
-- TOC entry 3458 (class 1259 OID 23503)
-- Name: messages_tenantId_channel_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "messages_tenantId_channel_idx" ON public.messages USING btree ("tenantId", channel);


--
-- TOC entry 3459 (class 1259 OID 23733)
-- Name: messages_tenantId_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "messages_tenantId_createdAt_idx" ON public.messages USING btree ("tenantId", "createdAt");


--
-- TOC entry 3460 (class 1259 OID 23732)
-- Name: messages_tenantId_status_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "messages_tenantId_status_createdAt_idx" ON public.messages USING btree ("tenantId", status, "createdAt");


--
-- TOC entry 3461 (class 1259 OID 23502)
-- Name: messages_tenantId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "messages_tenantId_status_idx" ON public.messages USING btree ("tenantId", status);


--
-- TOC entry 3536 (class 1259 OID 23727)
-- Name: payment_methods_razorpayPaymentMethodId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "payment_methods_razorpayPaymentMethodId_idx" ON public.payment_methods USING btree ("razorpayPaymentMethodId");


--
-- TOC entry 3537 (class 1259 OID 23724)
-- Name: payment_methods_razorpayPaymentMethodId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "payment_methods_razorpayPaymentMethodId_key" ON public.payment_methods USING btree ("razorpayPaymentMethodId");


--
-- TOC entry 3538 (class 1259 OID 23725)
-- Name: payment_methods_tenantId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "payment_methods_tenantId_idx" ON public.payment_methods USING btree ("tenantId");


--
-- TOC entry 3539 (class 1259 OID 23726)
-- Name: payment_methods_tenantId_isDefault_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "payment_methods_tenantId_isDefault_idx" ON public.payment_methods USING btree ("tenantId", "isDefault");


--
-- TOC entry 3479 (class 1259 OID 23513)
-- Name: segments_tenantId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "segments_tenantId_idx" ON public.segments USING btree ("tenantId");


--
-- TOC entry 3526 (class 1259 OID 23722)
-- Name: subscribers_emailVerificationToken_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "subscribers_emailVerificationToken_idx" ON public.subscribers USING btree ("emailVerificationToken");


--
-- TOC entry 3527 (class 1259 OID 23718)
-- Name: subscribers_emailVerificationToken_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "subscribers_emailVerificationToken_key" ON public.subscribers USING btree ("emailVerificationToken");


--
-- TOC entry 3530 (class 1259 OID 23719)
-- Name: subscribers_tenantId_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "subscribers_tenantId_email_idx" ON public.subscribers USING btree ("tenantId", email);


--
-- TOC entry 3531 (class 1259 OID 23723)
-- Name: subscribers_tenantId_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "subscribers_tenantId_email_key" ON public.subscribers USING btree ("tenantId", email);


--
-- TOC entry 3532 (class 1259 OID 23720)
-- Name: subscribers_tenantId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "subscribers_tenantId_status_idx" ON public.subscribers USING btree ("tenantId", status);


--
-- TOC entry 3533 (class 1259 OID 23721)
-- Name: subscribers_tenantId_tags_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "subscribers_tenantId_tags_idx" ON public.subscribers USING btree ("tenantId", tags);


--
-- TOC entry 3464 (class 1259 OID 23506)
-- Name: templates_tenantId_category_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templates_tenantId_category_idx" ON public.templates USING btree ("tenantId", category);


--
-- TOC entry 3465 (class 1259 OID 23507)
-- Name: templates_tenantId_channel_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templates_tenantId_channel_idx" ON public.templates USING btree ("tenantId", channel);


--
-- TOC entry 3466 (class 1259 OID 23737)
-- Name: templates_tenantId_feature_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templates_tenantId_feature_idx" ON public.templates USING btree ("tenantId", feature);


--
-- TOC entry 3467 (class 1259 OID 23736)
-- Name: templates_tenantId_industry_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templates_tenantId_industry_idx" ON public.templates USING btree ("tenantId", industry);


--
-- TOC entry 3468 (class 1259 OID 23734)
-- Name: templates_tenantId_isActive_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templates_tenantId_isActive_idx" ON public.templates USING btree ("tenantId", "isActive");


--
-- TOC entry 3469 (class 1259 OID 23735)
-- Name: templates_tenantId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "templates_tenantId_status_idx" ON public.templates USING btree ("tenantId", status);


--
-- TOC entry 3548 (class 1259 OID 23770)
-- Name: tenant_meta_credentials_tenantId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "tenant_meta_credentials_tenantId_idx" ON public.tenant_meta_credentials USING btree ("tenantId");


--
-- TOC entry 3549 (class 1259 OID 23769)
-- Name: tenant_meta_credentials_tenantId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "tenant_meta_credentials_tenantId_key" ON public.tenant_meta_credentials USING btree ("tenantId");


--
-- TOC entry 3440 (class 1259 OID 23494)
-- Name: tenants_customDomain_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "tenants_customDomain_key" ON public.tenants USING btree ("customDomain");


--
-- TOC entry 3443 (class 1259 OID 23495)
-- Name: tenants_razorpayCustomerId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "tenants_razorpayCustomerId_key" ON public.tenants USING btree ("razorpayCustomerId");


--
-- TOC entry 3444 (class 1259 OID 23496)
-- Name: tenants_razorpaySubscriptionId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "tenants_razorpaySubscriptionId_key" ON public.tenants USING btree ("razorpaySubscriptionId");


--
-- TOC entry 3445 (class 1259 OID 23497)
-- Name: tenants_slug_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenants_slug_idx ON public.tenants USING btree (slug);


--
-- TOC entry 3446 (class 1259 OID 23492)
-- Name: tenants_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tenants_slug_key ON public.tenants USING btree (slug);


--
-- TOC entry 3447 (class 1259 OID 23498)
-- Name: tenants_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenants_status_idx ON public.tenants USING btree (status);


--
-- TOC entry 3448 (class 1259 OID 23493)
-- Name: tenants_subdomain_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tenants_subdomain_key ON public.tenants USING btree (subdomain);


--
-- TOC entry 3451 (class 1259 OID 23499)
-- Name: users_tenantId_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "users_tenantId_email_idx" ON public.users USING btree ("tenantId", email);


--
-- TOC entry 3452 (class 1259 OID 23501)
-- Name: users_tenantId_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "users_tenantId_email_key" ON public.users USING btree ("tenantId", email);


--
-- TOC entry 3453 (class 1259 OID 23500)
-- Name: users_tenantId_role_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "users_tenantId_role_idx" ON public.users USING btree ("tenantId", role);


--
-- TOC entry 3542 (class 1259 OID 23728)
-- Name: waba_connections_tenantId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "waba_connections_tenantId_idx" ON public.waba_connections USING btree ("tenantId");


--
-- TOC entry 3543 (class 1259 OID 23729)
-- Name: waba_connections_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "waba_connections_userId_idx" ON public.waba_connections USING btree ("userId");


--
-- TOC entry 3544 (class 1259 OID 23731)
-- Name: waba_connections_userId_wabaId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "waba_connections_userId_wabaId_key" ON public.waba_connections USING btree ("userId", "wabaId");


--
-- TOC entry 3545 (class 1259 OID 23730)
-- Name: waba_connections_wabaId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "waba_connections_wabaId_idx" ON public.waba_connections USING btree ("wabaId");


--
-- TOC entry 3504 (class 1259 OID 23525)
-- Name: workflow_runs_tenantId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "workflow_runs_tenantId_idx" ON public.workflow_runs USING btree ("tenantId");


--
-- TOC entry 3505 (class 1259 OID 23524)
-- Name: workflow_runs_workflowId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "workflow_runs_workflowId_status_idx" ON public.workflow_runs USING btree ("workflowId", status);


--
-- TOC entry 3501 (class 1259 OID 23523)
-- Name: workflows_tenantId_isActive_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "workflows_tenantId_isActive_idx" ON public.workflows USING btree ("tenantId", "isActive");


--
-- TOC entry 3571 (class 2606 OID 23643)
-- Name: api_keys api_keys_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT "api_keys_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3572 (class 2606 OID 23648)
-- Name: api_logs api_logs_apiKeyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_logs
    ADD CONSTRAINT "api_logs_apiKeyId_fkey" FOREIGN KEY ("apiKeyId") REFERENCES public.api_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3573 (class 2606 OID 23653)
-- Name: audit_logs audit_logs_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT "audit_logs_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3574 (class 2606 OID 23658)
-- Name: audit_logs audit_logs_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT "audit_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3564 (class 2606 OID 23608)
-- Name: broadcast_messages broadcast_messages_broadcastId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcast_messages
    ADD CONSTRAINT "broadcast_messages_broadcastId_fkey" FOREIGN KEY ("broadcastId") REFERENCES public.broadcasts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3565 (class 2606 OID 23613)
-- Name: broadcast_messages broadcast_messages_messageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcast_messages
    ADD CONSTRAINT "broadcast_messages_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3563 (class 2606 OID 23603)
-- Name: broadcasts broadcasts_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broadcasts
    ADD CONSTRAINT "broadcasts_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3557 (class 2606 OID 23573)
-- Name: contact_segments contact_segments_contactId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_segments
    ADD CONSTRAINT "contact_segments_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public.contacts(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3558 (class 2606 OID 23578)
-- Name: contact_segments contact_segments_segmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_segments
    ADD CONSTRAINT "contact_segments_segmentId_fkey" FOREIGN KEY ("segmentId") REFERENCES public.segments(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3556 (class 2606 OID 23568)
-- Name: contacts contacts_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT "contacts_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3561 (class 2606 OID 23593)
-- Name: conversation_assignments conversation_assignments_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_assignments
    ADD CONSTRAINT "conversation_assignments_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public.conversations(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3562 (class 2606 OID 23598)
-- Name: conversation_assignments conversation_assignments_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversation_assignments
    ADD CONSTRAINT "conversation_assignments_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3559 (class 2606 OID 23588)
-- Name: conversations conversations_contactId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT "conversations_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public.contacts(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3560 (class 2606 OID 23583)
-- Name: conversations conversations_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT "conversations_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3570 (class 2606 OID 23638)
-- Name: invoices invoices_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT "invoices_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3551 (class 2606 OID 23548)
-- Name: messages messages_contactId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT "messages_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES public.contacts(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3552 (class 2606 OID 23558)
-- Name: messages messages_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT "messages_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public.conversations(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3553 (class 2606 OID 23553)
-- Name: messages messages_templateId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT "messages_templateId_fkey" FOREIGN KEY ("templateId") REFERENCES public.templates(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3554 (class 2606 OID 23543)
-- Name: messages messages_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT "messages_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3576 (class 2606 OID 23743)
-- Name: payment_methods payment_methods_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT "payment_methods_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3575 (class 2606 OID 23738)
-- Name: subscribers subscribers_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscribers
    ADD CONSTRAINT "subscribers_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3555 (class 2606 OID 23563)
-- Name: templates templates_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT "templates_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3579 (class 2606 OID 23771)
-- Name: tenant_meta_credentials tenant_meta_credentials_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_meta_credentials
    ADD CONSTRAINT "tenant_meta_credentials_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3550 (class 2606 OID 23538)
-- Name: users users_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3577 (class 2606 OID 23753)
-- Name: waba_connections waba_connections_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.waba_connections
    ADD CONSTRAINT "waba_connections_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3578 (class 2606 OID 23748)
-- Name: waba_connections waba_connections_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.waba_connections
    ADD CONSTRAINT "waba_connections_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3567 (class 2606 OID 23628)
-- Name: workflow_runs workflow_runs_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_runs
    ADD CONSTRAINT "workflow_runs_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3568 (class 2606 OID 23633)
-- Name: workflow_runs workflow_runs_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_runs
    ADD CONSTRAINT "workflow_runs_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3569 (class 2606 OID 23623)
-- Name: workflow_runs workflow_runs_workflowId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_runs
    ADD CONSTRAINT "workflow_runs_workflowId_fkey" FOREIGN KEY ("workflowId") REFERENCES public.workflows(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3566 (class 2606 OID 23618)
-- Name: workflows workflows_tenantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT "workflows_tenantId_fkey" FOREIGN KEY ("tenantId") REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3751 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2025-12-14 16:16:43

--
-- PostgreSQL database dump complete
--

\unrestrict gnavvXhHaVNkaCGmrmu9VTDHb96boaFavLKZ4JtpgXOclwYerAsyj7IatQvA8D8

