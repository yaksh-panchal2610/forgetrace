--
-- PostgreSQL database dump
--

\restrict DFcRjVlSZKgIJHEuclY9tEfVzaVYREHOnpISf1gQOVm8FNXhsYDjW3Iv077pDQG

-- Dumped from database version 17.12 (Debian 17.12-1.pgdg13+1)
-- Dumped by pg_dump version 17.12 (Debian 17.12-1.pgdg13+1)

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

ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_assigned_by_fkey;
ALTER TABLE IF EXISTS ONLY public.shipments DROP CONSTRAINT IF EXISTS shipments_production_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shipment_events DROP CONSTRAINT IF EXISTS shipment_events_shipment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shipment_batches DROP CONSTRAINT IF EXISTS shipment_batches_shipment_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shipment_batches DROP CONSTRAINT IF EXISTS shipment_batches_batch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.rfqs DROP CONSTRAINT IF EXISTS rfqs_process_id_fkey;
ALTER TABLE IF EXISTS ONLY public.rfqs DROP CONSTRAINT IF EXISTS rfqs_material_id_fkey;
ALTER TABLE IF EXISTS ONLY public.rfqs DROP CONSTRAINT IF EXISTS rfqs_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.rfqs DROP CONSTRAINT IF EXISTS rfqs_buyer_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.rfq_attachments DROP CONSTRAINT IF EXISTS rfq_attachments_uploaded_by_fkey;
ALTER TABLE IF EXISTS ONLY public.rfq_attachments DROP CONSTRAINT IF EXISTS rfq_attachments_rfq_id_fkey;
ALTER TABLE IF EXISTS ONLY public.rfq_attachments DROP CONSTRAINT IF EXISTS rfq_attachments_file_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_reviewer_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_manufacturer_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_buyer_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recalls DROP CONSTRAINT IF EXISTS recalls_initiated_by_fkey;
ALTER TABLE IF EXISTS ONLY public.recalls DROP CONSTRAINT IF EXISTS recalls_batch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recall_recipients DROP CONSTRAINT IF EXISTS recall_recipients_recall_id_fkey;
ALTER TABLE IF EXISTS ONLY public.recall_recipients DROP CONSTRAINT IF EXISTS recall_recipients_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_submitted_by_fkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_rfq_id_fkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_manufacturer_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS production_orders_rfq_id_fkey;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS production_orders_manufacturer_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS production_orders_buyer_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS production_orders_accepted_quotation_id_fkey;
ALTER TABLE IF EXISTS ONLY public.production_order_events DROP CONSTRAINT IF EXISTS production_order_events_updated_by_fkey;
ALTER TABLE IF EXISTS ONLY public.production_order_events DROP CONSTRAINT IF EXISTS production_order_events_production_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.product_passports DROP CONSTRAINT IF EXISTS product_passports_batch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_production_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS password_reset_tokens_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.organization_members DROP CONSTRAINT IF EXISTS organization_members_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.organization_members DROP CONSTRAINT IF EXISTS organization_members_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_profiles DROP CONSTRAINT IF EXISTS manufacturer_profiles_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_profiles DROP CONSTRAINT IF EXISTS manufacturer_profiles_approved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_processes DROP CONSTRAINT IF EXISTS manufacturer_processes_process_id_fkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_processes DROP CONSTRAINT IF EXISTS manufacturer_processes_manufacturer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_materials DROP CONSTRAINT IF EXISTS manufacturer_materials_material_id_fkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_materials DROP CONSTRAINT IF EXISTS manufacturer_materials_manufacturer_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machines DROP CONSTRAINT IF EXISTS machines_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_reservations DROP CONSTRAINT IF EXISTS machine_reservations_reserved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_reservations DROP CONSTRAINT IF EXISTS machine_reservations_production_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_reservations DROP CONSTRAINT IF EXISTS machine_reservations_machine_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_processes DROP CONSTRAINT IF EXISTS machine_processes_process_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_processes DROP CONSTRAINT IF EXISTS machine_processes_machine_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_materials DROP CONSTRAINT IF EXISTS machine_materials_material_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_materials DROP CONSTRAINT IF EXISTS machine_materials_machine_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_maintenance_blocks DROP CONSTRAINT IF EXISTS machine_maintenance_blocks_machine_id_fkey;
ALTER TABLE IF EXISTS ONLY public.machine_availability_rules DROP CONSTRAINT IF EXISTS machine_availability_rules_machine_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inspections DROP CONSTRAINT IF EXISTS inspections_inspector_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inspections DROP CONSTRAINT IF EXISTS inspections_batch_id_fkey;
ALTER TABLE IF EXISTS ONLY public.inspection_measurements DROP CONSTRAINT IF EXISTS inspection_measurements_inspection_id_fkey;
ALTER TABLE IF EXISTS ONLY public.file_objects DROP CONSTRAINT IF EXISTS file_objects_uploaded_by_fkey;
ALTER TABLE IF EXISTS ONLY public.file_objects DROP CONSTRAINT IF EXISTS file_objects_organization_id_fkey;
ALTER TABLE IF EXISTS ONLY public.disputes DROP CONSTRAINT IF EXISTS disputes_resolved_by_fkey;
ALTER TABLE IF EXISTS ONLY public.disputes DROP CONSTRAINT IF EXISTS disputes_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.disputes DROP CONSTRAINT IF EXISTS disputes_opened_by_fkey;
ALTER TABLE IF EXISTS ONLY public.batches DROP CONSTRAINT IF EXISTS batches_production_order_id_fkey;
ALTER TABLE IF EXISTS ONLY public.audit_logs DROP CONSTRAINT IF EXISTS audit_logs_actor_user_id_fkey;
DROP INDEX IF EXISTS public.idx_shipments_order;
DROP INDEX IF EXISTS public.idx_shipment_events_ship;
DROP INDEX IF EXISTS public.idx_rfqs_match;
DROP INDEX IF EXISTS public.idx_rfqs_buyer;
DROP INDEX IF EXISTS public.idx_reviews_mfr;
DROP INDEX IF EXISTS public.idx_reservations_order;
DROP INDEX IF EXISTS public.idx_reservations_machine;
DROP INDEX IF EXISTS public.idx_recalls_batch;
DROP INDEX IF EXISTS public.idx_quotations_rfq;
DROP INDEX IF EXISTS public.idx_quotations_mfr;
DROP INDEX IF EXISTS public.idx_payments_order;
DROP INDEX IF EXISTS public.idx_org_type_status;
DROP INDEX IF EXISTS public.idx_org_members_user;
DROP INDEX IF EXISTS public.idx_orders_mfr;
DROP INDEX IF EXISTS public.idx_orders_buyer;
DROP INDEX IF EXISTS public.idx_order_events_order;
DROP INDEX IF EXISTS public.idx_notifications_user;
DROP INDEX IF EXISTS public.idx_measurements_insp;
DROP INDEX IF EXISTS public.idx_maintenance_machine;
DROP INDEX IF EXISTS public.idx_machines_org;
DROP INDEX IF EXISTS public.idx_inspections_inspector;
DROP INDEX IF EXISTS public.idx_inspections_batch;
DROP INDEX IF EXISTS public.idx_files_org;
DROP INDEX IF EXISTS public.idx_disputes_order;
DROP INDEX IF EXISTS public.idx_batches_order;
DROP INDEX IF EXISTS public.idx_avail_rules_machine;
DROP INDEX IF EXISTS public.idx_audit_entity;
DROP INDEX IF EXISTS public.idx_audit_created;
DROP INDEX IF EXISTS public.flyway_schema_history_s_idx;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS uq_users_email;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS uq_roles_name;
ALTER TABLE IF EXISTS ONLY public.rfqs DROP CONSTRAINT IF EXISTS uq_rfq_number;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS uq_review_per_order;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS uq_reset_token_hash;
ALTER TABLE IF EXISTS ONLY public.recall_recipients DROP CONSTRAINT IF EXISTS uq_recall_recipient;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS uq_quotation_version;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS uq_quotation_number;
ALTER TABLE IF EXISTS ONLY public.manufacturing_processes DROP CONSTRAINT IF EXISTS uq_process_name;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS uq_payment_reference;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS uq_payment_idempotency;
ALTER TABLE IF EXISTS ONLY public.product_passports DROP CONSTRAINT IF EXISTS uq_passport_token;
ALTER TABLE IF EXISTS ONLY public.product_passports DROP CONSTRAINT IF EXISTS uq_passport_batch;
ALTER TABLE IF EXISTS ONLY public.organization_members DROP CONSTRAINT IF EXISTS uq_org_member;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS uq_order_rfq;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS uq_order_quotation;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS uq_order_number;
ALTER TABLE IF EXISTS ONLY public.materials DROP CONSTRAINT IF EXISTS uq_material_name;
ALTER TABLE IF EXISTS ONLY public.machines DROP CONSTRAINT IF EXISTS uq_machine_serial;
ALTER TABLE IF EXISTS ONLY public.file_objects DROP CONSTRAINT IF EXISTS uq_file_object_key;
ALTER TABLE IF EXISTS ONLY public.batches DROP CONSTRAINT IF EXISTS uq_batch_number;
ALTER TABLE IF EXISTS ONLY public.shipments DROP CONSTRAINT IF EXISTS shipments_pkey;
ALTER TABLE IF EXISTS ONLY public.shipment_events DROP CONSTRAINT IF EXISTS shipment_events_pkey;
ALTER TABLE IF EXISTS ONLY public.shipment_batches DROP CONSTRAINT IF EXISTS shipment_batches_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY public.rfqs DROP CONSTRAINT IF EXISTS rfqs_pkey;
ALTER TABLE IF EXISTS ONLY public.rfq_attachments DROP CONSTRAINT IF EXISTS rfq_attachments_pkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.recalls DROP CONSTRAINT IF EXISTS recalls_pkey;
ALTER TABLE IF EXISTS ONLY public.recall_recipients DROP CONSTRAINT IF EXISTS recall_recipients_pkey;
ALTER TABLE IF EXISTS ONLY public.quotations DROP CONSTRAINT IF EXISTS quotations_pkey;
ALTER TABLE IF EXISTS ONLY public.production_orders DROP CONSTRAINT IF EXISTS production_orders_pkey;
ALTER TABLE IF EXISTS ONLY public.production_order_events DROP CONSTRAINT IF EXISTS production_order_events_pkey;
ALTER TABLE IF EXISTS ONLY public.product_passports DROP CONSTRAINT IF EXISTS product_passports_pkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_pkey;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS password_reset_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.organizations DROP CONSTRAINT IF EXISTS organizations_pkey;
ALTER TABLE IF EXISTS ONLY public.organization_members DROP CONSTRAINT IF EXISTS organization_members_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.materials DROP CONSTRAINT IF EXISTS materials_pkey;
ALTER TABLE IF EXISTS ONLY public.manufacturing_processes DROP CONSTRAINT IF EXISTS manufacturing_processes_pkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_profiles DROP CONSTRAINT IF EXISTS manufacturer_profiles_pkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_processes DROP CONSTRAINT IF EXISTS manufacturer_processes_pkey;
ALTER TABLE IF EXISTS ONLY public.manufacturer_materials DROP CONSTRAINT IF EXISTS manufacturer_materials_pkey;
ALTER TABLE IF EXISTS ONLY public.machines DROP CONSTRAINT IF EXISTS machines_pkey;
ALTER TABLE IF EXISTS ONLY public.machine_reservations DROP CONSTRAINT IF EXISTS machine_reservations_pkey;
ALTER TABLE IF EXISTS ONLY public.machine_processes DROP CONSTRAINT IF EXISTS machine_processes_pkey;
ALTER TABLE IF EXISTS ONLY public.machine_materials DROP CONSTRAINT IF EXISTS machine_materials_pkey;
ALTER TABLE IF EXISTS ONLY public.machine_maintenance_blocks DROP CONSTRAINT IF EXISTS machine_maintenance_blocks_pkey;
ALTER TABLE IF EXISTS ONLY public.machine_availability_rules DROP CONSTRAINT IF EXISTS machine_availability_rules_pkey;
ALTER TABLE IF EXISTS ONLY public.inspections DROP CONSTRAINT IF EXISTS inspections_pkey;
ALTER TABLE IF EXISTS ONLY public.inspection_measurements DROP CONSTRAINT IF EXISTS inspection_measurements_pkey;
ALTER TABLE IF EXISTS ONLY public.flyway_schema_history DROP CONSTRAINT IF EXISTS flyway_schema_history_pk;
ALTER TABLE IF EXISTS ONLY public.file_objects DROP CONSTRAINT IF EXISTS file_objects_pkey;
ALTER TABLE IF EXISTS ONLY public.machine_reservations DROP CONSTRAINT IF EXISTS ex_reservation_no_overlap;
ALTER TABLE IF EXISTS ONLY public.disputes DROP CONSTRAINT IF EXISTS disputes_pkey;
ALTER TABLE IF EXISTS ONLY public.contact_requests DROP CONSTRAINT IF EXISTS contact_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.batches DROP CONSTRAINT IF EXISTS batches_pkey;
ALTER TABLE IF EXISTS ONLY public.audit_logs DROP CONSTRAINT IF EXISTS audit_logs_pkey;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.user_roles;
DROP TABLE IF EXISTS public.shipments;
DROP TABLE IF EXISTS public.shipment_events;
DROP TABLE IF EXISTS public.shipment_batches;
DROP TABLE IF EXISTS public.roles;
DROP TABLE IF EXISTS public.rfqs;
DROP TABLE IF EXISTS public.rfq_attachments;
DROP TABLE IF EXISTS public.reviews;
DROP TABLE IF EXISTS public.recalls;
DROP TABLE IF EXISTS public.recall_recipients;
DROP TABLE IF EXISTS public.quotations;
DROP TABLE IF EXISTS public.production_orders;
DROP TABLE IF EXISTS public.production_order_events;
DROP TABLE IF EXISTS public.product_passports;
DROP TABLE IF EXISTS public.payments;
DROP TABLE IF EXISTS public.password_reset_tokens;
DROP TABLE IF EXISTS public.organizations;
DROP TABLE IF EXISTS public.organization_members;
DROP TABLE IF EXISTS public.notifications;
DROP TABLE IF EXISTS public.materials;
DROP TABLE IF EXISTS public.manufacturing_processes;
DROP TABLE IF EXISTS public.manufacturer_profiles;
DROP TABLE IF EXISTS public.manufacturer_processes;
DROP TABLE IF EXISTS public.manufacturer_materials;
DROP TABLE IF EXISTS public.machines;
DROP TABLE IF EXISTS public.machine_reservations;
DROP TABLE IF EXISTS public.machine_processes;
DROP TABLE IF EXISTS public.machine_materials;
DROP TABLE IF EXISTS public.machine_maintenance_blocks;
DROP TABLE IF EXISTS public.machine_availability_rules;
DROP TABLE IF EXISTS public.inspections;
DROP TABLE IF EXISTS public.inspection_measurements;
DROP TABLE IF EXISTS public.flyway_schema_history;
DROP TABLE IF EXISTS public.file_objects;
DROP TABLE IF EXISTS public.disputes;
DROP TABLE IF EXISTS public.contact_requests;
DROP TABLE IF EXISTS public.batches;
DROP TABLE IF EXISTS public.audit_logs;
DROP EXTENSION IF EXISTS btree_gist;
--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    actor_user_id bigint,
    action character varying(60) NOT NULL,
    entity_type character varying(60) NOT NULL,
    entity_id bigint,
    details text,
    ip_address character varying(45),
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.audit_logs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.batches (
    id bigint NOT NULL,
    production_order_id bigint NOT NULL,
    batch_number character varying(40) NOT NULL,
    quantity numeric(14,3) NOT NULL,
    manufacture_date date,
    status character varying(25) DEFAULT 'CREATED'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_batch_quantity CHECK ((quantity > (0)::numeric)),
    CONSTRAINT ck_batch_status CHECK (((status)::text = ANY ((ARRAY['CREATED'::character varying, 'IN_PROGRESS'::character varying, 'AWAITING_INSPECTION'::character varying, 'APPROVED'::character varying, 'REJECTED'::character varying, 'ON_HOLD'::character varying, 'SHIPPED'::character varying, 'RECALLED'::character varying])::text[])))
);


--
-- Name: batches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.batches ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.batches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: contact_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_requests (
    id bigint NOT NULL,
    name character varying(120) NOT NULL,
    email character varying(160) NOT NULL,
    subject character varying(160) NOT NULL,
    message text NOT NULL,
    status character varying(20) DEFAULT 'NEW'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_contact_status CHECK (((status)::text = ANY ((ARRAY['NEW'::character varying, 'IN_PROGRESS'::character varying, 'RESOLVED'::character varying])::text[])))
);


--
-- Name: contact_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.contact_requests ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.contact_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: disputes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.disputes (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    opened_by bigint NOT NULL,
    reason character varying(160) NOT NULL,
    description text,
    status character varying(20) DEFAULT 'OPEN'::character varying NOT NULL,
    resolution text,
    resolved_by bigint,
    resolved_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_dispute_status CHECK (((status)::text = ANY ((ARRAY['OPEN'::character varying, 'UNDER_REVIEW'::character varying, 'RESOLVED'::character varying, 'REJECTED'::character varying])::text[])))
);


--
-- Name: disputes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.disputes ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.disputes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: file_objects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_objects (
    id bigint NOT NULL,
    bucket character varying(100) NOT NULL,
    object_key character varying(500) NOT NULL,
    original_filename character varying(255) NOT NULL,
    content_type character varying(100) NOT NULL,
    size_bytes bigint NOT NULL,
    uploaded_by bigint NOT NULL,
    organization_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_file_size CHECK ((size_bytes > 0))
);


--
-- Name: file_objects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.file_objects ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.file_objects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- Name: inspection_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inspection_measurements (
    id bigint NOT NULL,
    inspection_id bigint NOT NULL,
    parameter_name character varying(100) NOT NULL,
    expected_min numeric(14,4) NOT NULL,
    expected_max numeric(14,4) NOT NULL,
    actual_value numeric(14,4) NOT NULL,
    unit character varying(20) NOT NULL,
    result character varying(10) NOT NULL,
    remarks character varying(255),
    CONSTRAINT ck_measure_range CHECK ((expected_max >= expected_min)),
    CONSTRAINT ck_measure_result CHECK (((result)::text = ANY ((ARRAY['PASS'::character varying, 'FAIL'::character varying])::text[])))
);


--
-- Name: inspection_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.inspection_measurements ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inspection_measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inspections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inspections (
    id bigint NOT NULL,
    batch_id bigint NOT NULL,
    inspector_user_id bigint NOT NULL,
    inspection_type character varying(20) DEFAULT 'FINAL'::character varying NOT NULL,
    status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    findings text,
    inspected_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_inspection_status CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'PASSED'::character varying, 'FAILED'::character varying, 'ON_HOLD'::character varying])::text[]))),
    CONSTRAINT ck_inspection_type CHECK (((inspection_type)::text = ANY ((ARRAY['INCOMING'::character varying, 'IN_PROCESS'::character varying, 'FINAL'::character varying])::text[])))
);


--
-- Name: inspections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.inspections ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.inspections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: machine_availability_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.machine_availability_rules (
    id bigint NOT NULL,
    machine_id bigint NOT NULL,
    day_of_week integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    valid_from date DEFAULT CURRENT_DATE NOT NULL,
    valid_until date,
    active boolean DEFAULT true NOT NULL,
    CONSTRAINT ck_rule_dates CHECK (((valid_until IS NULL) OR (valid_until >= valid_from))),
    CONSTRAINT ck_rule_day CHECK (((day_of_week >= 1) AND (day_of_week <= 7))),
    CONSTRAINT ck_rule_time CHECK ((end_time > start_time))
);


--
-- Name: machine_availability_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.machine_availability_rules ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.machine_availability_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: machine_maintenance_blocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.machine_maintenance_blocks (
    id bigint NOT NULL,
    machine_id bigint NOT NULL,
    start_at timestamp with time zone NOT NULL,
    end_at timestamp with time zone NOT NULL,
    reason character varying(255),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_maintenance_range CHECK ((end_at > start_at))
);


--
-- Name: machine_maintenance_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.machine_maintenance_blocks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.machine_maintenance_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: machine_materials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.machine_materials (
    machine_id bigint NOT NULL,
    material_id bigint NOT NULL
);


--
-- Name: machine_processes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.machine_processes (
    machine_id bigint NOT NULL,
    process_id bigint NOT NULL
);


--
-- Name: machine_reservations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.machine_reservations (
    id bigint NOT NULL,
    machine_id bigint NOT NULL,
    production_order_id bigint NOT NULL,
    start_at timestamp with time zone NOT NULL,
    end_at timestamp with time zone NOT NULL,
    status character varying(20) DEFAULT 'ACTIVE'::character varying NOT NULL,
    reserved_by bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_reservation_range CHECK ((end_at > start_at)),
    CONSTRAINT ck_reservation_status CHECK (((status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'COMPLETED'::character varying, 'CANCELLED'::character varying])::text[])))
);


--
-- Name: machine_reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.machine_reservations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.machine_reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: machines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.machines (
    id bigint NOT NULL,
    organization_id bigint NOT NULL,
    machine_name character varying(120) NOT NULL,
    machine_type character varying(80) NOT NULL,
    model_number character varying(80),
    serial_number character varying(80),
    capacity_value numeric(12,2),
    capacity_unit character varying(30),
    machine_status character varying(20) DEFAULT 'ACTIVE'::character varying NOT NULL,
    location character varying(160),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_machine_capacity CHECK (((capacity_value IS NULL) OR (capacity_value > (0)::numeric))),
    CONSTRAINT ck_machine_status CHECK (((machine_status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'MAINTENANCE'::character varying, 'INACTIVE'::character varying])::text[])))
);


--
-- Name: machines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.machines ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.machines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: manufacturer_materials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacturer_materials (
    manufacturer_id bigint NOT NULL,
    material_id bigint NOT NULL
);


--
-- Name: manufacturer_processes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacturer_processes (
    manufacturer_id bigint NOT NULL,
    process_id bigint NOT NULL
);


--
-- Name: manufacturer_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacturer_profiles (
    organization_id bigint NOT NULL,
    description text,
    years_in_operation integer,
    website_url character varying(255),
    verification_notes text,
    approved_at timestamp with time zone,
    approved_by bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_years_positive CHECK (((years_in_operation IS NULL) OR (years_in_operation >= 0)))
);


--
-- Name: manufacturing_processes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacturing_processes (
    id bigint NOT NULL,
    process_name character varying(80) NOT NULL,
    description character varying(255),
    active boolean DEFAULT true NOT NULL
);


--
-- Name: manufacturing_processes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.manufacturing_processes ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.manufacturing_processes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: materials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.materials (
    id bigint NOT NULL,
    material_name character varying(80) NOT NULL,
    material_category character varying(60),
    description character varying(255),
    active boolean DEFAULT true NOT NULL
);


--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.materials ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.materials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    title character varying(160) NOT NULL,
    message text NOT NULL,
    link_url character varying(255),
    read_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.notifications ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: organization_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_members (
    id bigint NOT NULL,
    organization_id bigint NOT NULL,
    user_id bigint NOT NULL,
    membership_role character varying(20) DEFAULT 'MEMBER'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    joined_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_member_role CHECK (((membership_role)::text = ANY ((ARRAY['OWNER'::character varying, 'ADMIN'::character varying, 'MEMBER'::character varying])::text[])))
);


--
-- Name: organization_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.organization_members ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.organization_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    legal_name character varying(200) NOT NULL,
    display_name character varying(120) NOT NULL,
    organization_type character varying(20) NOT NULL,
    registration_number character varying(60),
    tax_id character varying(30),
    email character varying(160),
    phone character varying(30),
    address_line1 character varying(200),
    address_line2 character varying(200),
    city character varying(80),
    state character varying(80),
    postal_code character varying(20),
    country character varying(60) DEFAULT 'India'::character varying NOT NULL,
    verification_status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_org_type CHECK (((organization_type)::text = ANY ((ARRAY['BUYER'::character varying, 'MANUFACTURER'::character varying, 'PLATFORM'::character varying])::text[]))),
    CONSTRAINT ck_org_verification CHECK (((verification_status)::text = ANY ((ARRAY['PENDING'::character varying, 'VERIFIED'::character varying, 'REJECTED'::character varying])::text[])))
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.organizations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token_hash character varying(100) NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    used_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.password_reset_tokens ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.password_reset_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    production_order_id bigint NOT NULL,
    payment_reference character varying(40) NOT NULL,
    provider character varying(30) DEFAULT 'SANDBOX'::character varying NOT NULL,
    provider_reference character varying(100),
    idempotency_key character varying(80) NOT NULL,
    amount numeric(14,2) NOT NULL,
    currency character varying(3) DEFAULT 'INR'::character varying NOT NULL,
    payment_method character varying(20) NOT NULL,
    status character varying(20) DEFAULT 'CREATED'::character varying NOT NULL,
    failure_reason character varying(255),
    paid_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_payment_amount CHECK ((amount > (0)::numeric)),
    CONSTRAINT ck_payment_method CHECK (((payment_method)::text = ANY ((ARRAY['CARD'::character varying, 'UPI'::character varying, 'NET_BANKING'::character varying, 'WALLET'::character varying, 'SANDBOX'::character varying])::text[]))),
    CONSTRAINT ck_payment_status CHECK (((status)::text = ANY ((ARRAY['CREATED'::character varying, 'PENDING'::character varying, 'SUCCEEDED'::character varying, 'FAILED'::character varying, 'REFUNDED'::character varying])::text[])))
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.payments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: product_passports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_passports (
    id bigint NOT NULL,
    batch_id bigint NOT NULL,
    public_token uuid NOT NULL,
    qr_file_key character varying(500),
    visibility_status character varying(20) DEFAULT 'PUBLIC'::character varying NOT NULL,
    published_at timestamp with time zone,
    revoked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_passport_visibility CHECK (((visibility_status)::text = ANY ((ARRAY['PUBLIC'::character varying, 'REVOKED'::character varying])::text[])))
);


--
-- Name: product_passports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.product_passports ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.product_passports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: production_order_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.production_order_events (
    id bigint NOT NULL,
    production_order_id bigint NOT NULL,
    previous_status character varying(20),
    new_status character varying(20) NOT NULL,
    updated_by bigint NOT NULL,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: production_order_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.production_order_events ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.production_order_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: production_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.production_orders (
    id bigint NOT NULL,
    order_number character varying(30) NOT NULL,
    accepted_quotation_id bigint NOT NULL,
    rfq_id bigint NOT NULL,
    buyer_organization_id bigint NOT NULL,
    manufacturer_organization_id bigint NOT NULL,
    quantity numeric(14,3) NOT NULL,
    total_amount numeric(14,2) NOT NULL,
    currency character varying(3) DEFAULT 'INR'::character varying NOT NULL,
    expected_completion date,
    status character varying(20) DEFAULT 'CONFIRMED'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_order_amount CHECK ((total_amount >= (0)::numeric)),
    CONSTRAINT ck_order_quantity CHECK ((quantity > (0)::numeric)),
    CONSTRAINT ck_order_status CHECK (((status)::text = ANY ((ARRAY['CONFIRMED'::character varying, 'SCHEDULED'::character varying, 'IN_PRODUCTION'::character varying, 'QUALITY_CHECK'::character varying, 'READY_TO_SHIP'::character varying, 'SHIPPED'::character varying, 'DELIVERED'::character varying, 'COMPLETED'::character varying, 'ON_HOLD'::character varying, 'CANCELLED'::character varying])::text[])))
);


--
-- Name: production_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.production_orders ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.production_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: quotations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quotations (
    id bigint NOT NULL,
    quotation_number character varying(30) NOT NULL,
    rfq_id bigint NOT NULL,
    manufacturer_organization_id bigint NOT NULL,
    submitted_by bigint NOT NULL,
    version_number integer DEFAULT 1 NOT NULL,
    unit_price numeric(14,2) NOT NULL,
    setup_fee numeric(14,2) DEFAULT 0 NOT NULL,
    tax_amount numeric(14,2) DEFAULT 0 NOT NULL,
    total_amount numeric(14,2) NOT NULL,
    currency character varying(3) DEFAULT 'INR'::character varying NOT NULL,
    lead_time_days integer NOT NULL,
    valid_until timestamp with time zone NOT NULL,
    terms text,
    status character varying(20) DEFAULT 'SUBMITTED'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_quote_lead CHECK ((lead_time_days > 0)),
    CONSTRAINT ck_quote_money CHECK (((unit_price >= (0)::numeric) AND (setup_fee >= (0)::numeric) AND (tax_amount >= (0)::numeric) AND (total_amount >= (0)::numeric))),
    CONSTRAINT ck_quote_status CHECK (((status)::text = ANY ((ARRAY['SUBMITTED'::character varying, 'SUPERSEDED'::character varying, 'ACCEPTED'::character varying, 'REJECTED'::character varying, 'EXPIRED'::character varying, 'WITHDRAWN'::character varying])::text[]))),
    CONSTRAINT ck_quote_version CHECK ((version_number >= 1))
);


--
-- Name: quotations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.quotations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.quotations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: recall_recipients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recall_recipients (
    id bigint NOT NULL,
    recall_id bigint NOT NULL,
    organization_id bigint NOT NULL,
    notified_at timestamp with time zone,
    acknowledgement_status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    acknowledged_at timestamp with time zone,
    CONSTRAINT ck_recall_ack CHECK (((acknowledgement_status)::text = ANY ((ARRAY['PENDING'::character varying, 'ACKNOWLEDGED'::character varying])::text[])))
);


--
-- Name: recall_recipients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.recall_recipients ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.recall_recipients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: recalls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recalls (
    id bigint NOT NULL,
    batch_id bigint NOT NULL,
    initiated_by bigint NOT NULL,
    reason text NOT NULL,
    severity character varying(20) NOT NULL,
    status character varying(20) DEFAULT 'INITIATED'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_recall_severity CHECK (((severity)::text = ANY ((ARRAY['LOW'::character varying, 'MEDIUM'::character varying, 'HIGH'::character varying, 'CRITICAL'::character varying])::text[]))),
    CONSTRAINT ck_recall_status CHECK (((status)::text = ANY ((ARRAY['INITIATED'::character varying, 'NOTIFIED'::character varying, 'CLOSED'::character varying])::text[])))
);


--
-- Name: recalls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.recalls ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.recalls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    buyer_organization_id bigint NOT NULL,
    manufacturer_organization_id bigint NOT NULL,
    reviewer_user_id bigint NOT NULL,
    rating integer NOT NULL,
    comment text,
    verified_purchase boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_review_rating CHECK (((rating >= 1) AND (rating <= 5)))
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.reviews ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: rfq_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rfq_attachments (
    id bigint NOT NULL,
    rfq_id bigint NOT NULL,
    file_id bigint NOT NULL,
    uploaded_by bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: rfq_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.rfq_attachments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.rfq_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: rfqs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rfqs (
    id bigint NOT NULL,
    rfq_number character varying(30) NOT NULL,
    buyer_organization_id bigint NOT NULL,
    created_by bigint NOT NULL,
    title character varying(160) NOT NULL,
    description text,
    process_id bigint NOT NULL,
    material_id bigint NOT NULL,
    quantity numeric(14,3) NOT NULL,
    quantity_unit character varying(20) DEFAULT 'pcs'::character varying NOT NULL,
    specifications jsonb,
    tolerance_notes text,
    delivery_date date NOT NULL,
    delivery_address text NOT NULL,
    quote_deadline timestamp with time zone NOT NULL,
    status character varying(20) DEFAULT 'OPEN'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_rfq_quantity CHECK ((quantity > (0)::numeric)),
    CONSTRAINT ck_rfq_status CHECK (((status)::text = ANY ((ARRAY['DRAFT'::character varying, 'OPEN'::character varying, 'CLOSED'::character varying, 'AWARDED'::character varying, 'CANCELLED'::character varying, 'EXPIRED'::character varying])::text[])))
);


--
-- Name: rfqs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.rfqs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.rfqs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    role_name character varying(40) NOT NULL,
    description character varying(200)
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipment_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipment_batches (
    shipment_id bigint NOT NULL,
    batch_id bigint NOT NULL,
    quantity numeric(14,3) NOT NULL,
    CONSTRAINT ck_shipment_batch_qty CHECK ((quantity > (0)::numeric))
);


--
-- Name: shipment_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipment_events (
    id bigint NOT NULL,
    shipment_id bigint NOT NULL,
    event_status character varying(20) NOT NULL,
    event_time timestamp with time zone DEFAULT now() NOT NULL,
    location character varying(160),
    remarks character varying(255),
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: shipment_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.shipment_events ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.shipment_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: shipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipments (
    id bigint NOT NULL,
    production_order_id bigint NOT NULL,
    carrier_name character varying(100) NOT NULL,
    tracking_number character varying(100),
    dispatch_date date,
    expected_delivery date,
    delivered_at timestamp with time zone,
    status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_shipment_dates CHECK (((expected_delivery IS NULL) OR (dispatch_date IS NULL) OR (expected_delivery >= dispatch_date))),
    CONSTRAINT ck_shipment_status CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'DISPATCHED'::character varying, 'IN_TRANSIT'::character varying, 'DELIVERED'::character varying, 'RETURNED'::character varying, 'CANCELLED'::character varying])::text[])))
);


--
-- Name: shipments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.shipments ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.shipments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    assigned_at timestamp with time zone DEFAULT now() NOT NULL,
    assigned_by bigint
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    full_name character varying(120) NOT NULL,
    email character varying(160) NOT NULL,
    password_hash character varying(100) NOT NULL,
    phone character varying(30),
    account_status character varying(20) DEFAULT 'ACTIVE'::character varying NOT NULL,
    email_verified boolean DEFAULT false NOT NULL,
    last_login_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_users_status CHECK (((account_status)::text = ANY ((ARRAY['PENDING'::character varying, 'ACTIVE'::character varying, 'SUSPENDED'::character varying])::text[])))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_logs (id, actor_user_id, action, entity_type, entity_id, details, ip_address, created_at) FROM stdin;
1	1	LOGIN	User	1	\N	0:0:0:0:0:0:0:1	2026-11-24 11:37:34.407769+00
2	3	REGISTER_MANUFACTURER	Organization	2	Webmints	0:0:0:0:0:0:0:1	2026-11-24 13:09:38.513432+00
3	3	LOGIN	User	3	\N	0:0:0:0:0:0:0:1	2026-11-24 13:09:44.792041+00
4	1	LOGIN	User	1	\N	0:0:0:0:0:0:0:1	2026-11-24 15:39:49.374177+00
5	1	LOGIN	User	1	\N	0:0:0:0:0:0:0:1	2026-11-24 16:20:25.590299+00
6	124	LOGIN	User	124	\N	0:0:0:0:0:0:0:1	2026-11-24 16:22:23.365007+00
7	1	LOGIN	User	1	\N	0:0:0:0:0:0:0:1	2026-11-24 16:22:59.441977+00
8	124	LOGIN	User	124	\N	0:0:0:0:0:0:0:1	2026-11-24 16:36:03.360662+00
9	131	LOGIN	User	131	\N	0:0:0:0:0:0:0:1	2026-11-24 16:48:00.880755+00
10	131	PAYMENT_SUCCEEDED	Payment	65	PAY-2026-SYZ8EFEX	0:0:0:0:0:0:0:1	2026-11-24 16:49:00.102117+00
11	254	REGISTER_BUYER	Organization	243	GreenVolt Energy Pvt Ltd	0:0:0:0:0:0:0:1	2026-11-24 16:52:44.899453+00
12	254	LOGIN	User	254	\N	0:0:0:0:0:0:0:1	2026-11-24 16:53:24.210679+00
13	255	REGISTER_MANUFACTURER	Organization	244	Patil Fabrication Works Pvt Ltd	0:0:0:0:0:0:0:1	2026-11-24 16:55:50.914322+00
14	255	LOGIN	User	255	\N	0:0:0:0:0:0:0:1	2026-11-24 16:58:43.671609+00
15	1	LOGIN	User	1	\N	0:0:0:0:0:0:0:1	2026-11-24 16:59:59.638769+00
16	1	MANUFACTURER_VERIFIED	Organization	244	Documents checked	0:0:0:0:0:0:0:1	2026-11-24 17:00:34.559875+00
47	1	LOGIN	User	1	\N	0:0:0:0:0:0:0:1	2026-11-25 00:01:16.363253+00
48	2	LOGIN	User	2	\N	0:0:0:0:0:0:0:1	2026-11-25 00:01:55.348557+00
49	254	LOGIN	User	254	\N	0:0:0:0:0:0:0:1	2026-11-25 00:02:30.098721+00
50	255	LOGIN	User	255	\N	0:0:0:0:0:0:0:1	2026-11-25 00:02:59.35465+00
51	255	MACHINE_CREATED	Machine	441	Fiber Laser 3015 #1	0:0:0:0:0:0:0:1	2026-11-25 00:07:46.099158+00
52	255	AVAILABILITY_ADDED	Machine	441	6 day(s) 09:00-18:00	0:0:0:0:0:0:0:1	2026-11-25 00:09:07.946753+00
53	254	LOGIN	User	254	\N	0:0:0:0:0:0:0:1	2026-11-25 00:10:16.45178+00
54	254	RFQ_CREATED	Rfq	86	RFQ-2026-CZ8V728E	0:0:0:0:0:0:0:1	2026-11-25 00:13:10.039797+00
55	255	LOGIN	User	255	\N	0:0:0:0:0:0:0:1	2026-11-25 00:14:14.697503+00
56	255	QUOTATION_SUBMITTED	Quotation	184	QTN-2026-ANJAXC2U v1	0:0:0:0:0:0:0:1	2026-11-25 00:15:42.538962+00
57	254	ORDER_CREATED	ProductionOrder	61	ORD-2026-QRKEE74S from QTN-2026-ANJAXC2U	0:0:0:0:0:0:0:1	2026-11-25 00:24:41.683643+00
58	254	PAYMENT_FAILED	Payment	66	Card number is not valid.	0:0:0:0:0:0:0:1	2026-11-25 00:25:35.759254+00
59	254	PAYMENT_SUCCEEDED	Payment	67	PAY-2026-TMC5RGQW	0:0:0:0:0:0:0:1	2026-11-25 00:25:47.650498+00
60	254	RFQ_CREATED	Rfq	87	RFQ-2026-TBQZCX6X	0:0:0:0:0:0:0:1	2026-11-25 00:42:11.430377+00
61	255	QUOTATION_SUBMITTED	Quotation	185	QTN-2026-9CYBXSRQ v1	0:0:0:0:0:0:0:1	2026-11-25 00:43:42.145596+00
62	254	ORDER_CREATED	ProductionOrder	62	ORD-2026-SXECNPKH from QTN-2026-9CYBXSRQ	0:0:0:0:0:0:0:1	2026-11-25 00:44:36.597486+00
63	254	PAYMENT_SUCCEEDED	Payment	68	PAY-2026-8C729A35	0:0:0:0:0:0:0:1	2026-11-25 00:46:00.615217+00
\.


--
-- Data for Name: batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.batches (id, production_order_id, batch_number, quantity, manufacture_date, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: contact_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contact_requests (id, name, email, subject, message, status, created_at) FROM stdin;
1	Ananya Rao	contact001@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-24 10:55:54.490593+00
2	Ayesha Khan	contact002@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-24 05:55:54.490593+00
3	Prakash Agarwal	contact003@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-24 00:55:54.490593+00
4	Shreya Pandey	contact004@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-23 19:55:54.490593+00
5	Karan DSouza	contact005@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-23 14:55:54.490593+00
6	Divya Patel	contact006@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-23 09:55:54.490593+00
7	Joseph Deshmukh	contact007@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-23 04:55:54.490593+00
8	Sunil Menon	contact008@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-22 23:55:54.490593+00
9	Geeta Kapoor	contact009@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-22 18:55:54.490593+00
10	Priya Naidu	contact010@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-22 13:55:54.490593+00
11	Farhan Saxena	contact011@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-22 08:55:54.490593+00
12	Nitin Iyer	contact012@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-22 03:55:54.490593+00
13	Anjali Patil	contact013@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-21 22:55:54.490593+00
14	Rohan Banerjee	contact014@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-21 17:55:54.490593+00
15	Kavya Chauhan	contact015@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-21 12:55:54.490593+00
16	Manpreet Hegde	contact016@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-21 07:55:54.490593+00
17	Arun Bose	contact017@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-21 02:55:54.490593+00
18	Rekha Reddy	contact018@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-20 21:55:54.490593+00
19	Ramesh Gill	contact019@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-20 16:55:54.490593+00
20	Imran Mehta	contact020@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-20 11:55:54.490593+00
21	Sanjay Mishra	contact021@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-20 06:55:54.490593+00
22	Ritu Fernandes	contact022@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-20 01:55:54.490593+00
23	Arjun Verma	contact023@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-19 20:55:54.490593+00
24	Neha Kulkarni	contact024@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-19 15:55:54.490593+00
25	Harpreet Qureshi	contact025@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-19 10:55:54.490593+00
26	Kiran Gupta	contact026@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-19 05:55:54.490593+00
27	Nisha Das	contact027@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-19 00:55:54.490593+00
28	Suresh Thakur	contact028@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-18 19:55:54.490593+00
29	Deepa Shah	contact029@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-18 14:55:54.490593+00
30	Vikram Joshi	contact030@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-18 09:55:54.490593+00
31	Sonal Pillai	contact031@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-18 04:55:54.490593+00
32	Aditya Malhotra	contact032@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-17 23:55:54.490593+00
33	Pooja Gowda	contact033@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-17 18:55:54.490593+00
34	Gurpreet Sinha	contact034@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-17 13:55:54.490593+00
35	Nirav Nair	contact035@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-17 08:55:54.490593+00
36	Tanvi Singh	contact036@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-17 03:55:54.490593+00
37	Amit Chatterjee	contact037@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-16 22:55:54.490593+00
38	Lakshmi Yadav	contact038@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-16 17:55:54.490593+00
39	Thomas Bhat	contact039@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-16 12:55:54.490593+00
40	Swati Sharma	contact040@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-16 07:55:54.490593+00
41	Vivaan Rao	contact041@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-16 02:55:54.490593+00
42	Sneha Khan	contact042@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-15 21:55:54.490593+00
43	Zoya Agarwal	contact043@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-15 16:55:54.490593+00
44	Hitesh Pandey	contact044@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-15 11:55:54.490593+00
45	Isha DSouza	contact045@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-15 06:55:54.490593+00
46	Rahul Patel	contact046@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-15 01:55:54.490593+00
47	Meena Deshmukh	contact047@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-14 20:55:54.490593+00
48	Mary Menon	contact048@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-14 15:55:54.490593+00
49	Manoj Kapoor	contact049@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-14 10:55:54.490593+00
50	Aarav Naidu	contact050@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-14 05:55:54.490593+00
51	Ananya Saxena	contact051@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-14 00:55:54.490593+00
52	Ayesha Iyer	contact052@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-13 19:55:54.490593+00
53	Prakash Patil	contact053@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-13 14:55:54.490593+00
54	Shreya Banerjee	contact054@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-13 09:55:54.490593+00
55	Karan Chauhan	contact055@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-13 04:55:54.490593+00
56	Divya Hegde	contact056@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-12 23:55:54.490593+00
57	Joseph Bose	contact057@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-12 18:55:54.490593+00
58	Sunil Reddy	contact058@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-12 13:55:54.490593+00
59	Geeta Gill	contact059@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-12 08:55:54.490593+00
60	Priya Mehta	contact060@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-12 03:55:54.490593+00
61	Farhan Mishra	contact061@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-11 22:55:54.490593+00
62	Nitin Fernandes	contact062@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-11 17:55:54.490593+00
63	Anjali Verma	contact063@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-11 12:55:54.490593+00
64	Rohan Kulkarni	contact064@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-11 07:55:54.490593+00
65	Kavya Qureshi	contact065@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-11 02:55:54.490593+00
66	Manpreet Gupta	contact066@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-10 21:55:54.490593+00
67	Arun Das	contact067@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-10 16:55:54.490593+00
68	Rekha Thakur	contact068@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-10 11:55:54.490593+00
69	Ramesh Shah	contact069@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-10 06:55:54.490593+00
70	Imran Joshi	contact070@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-10 01:55:54.490593+00
71	Sanjay Pillai	contact071@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-09 20:55:54.490593+00
72	Ritu Malhotra	contact072@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-09 15:55:54.490593+00
73	Arjun Gowda	contact073@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-09 10:55:54.490593+00
74	Neha Sinha	contact074@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-09 05:55:54.490593+00
75	Harpreet Nair	contact075@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-09 00:55:54.490593+00
76	Kiran Singh	contact076@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-08 19:55:54.490593+00
77	Nisha Chatterjee	contact077@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-08 14:55:54.490593+00
78	Suresh Yadav	contact078@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-08 09:55:54.490593+00
79	Deepa Bhat	contact079@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-08 04:55:54.490593+00
80	Vikram Sharma	contact080@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-07 23:55:54.490593+00
81	Sonal Rao	contact081@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-07 18:55:54.490593+00
82	Aditya Khan	contact082@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-07 13:55:54.490593+00
83	Pooja Agarwal	contact083@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-07 08:55:54.490593+00
84	Gurpreet Pandey	contact084@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-07 03:55:54.490593+00
85	Nirav DSouza	contact085@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-06 22:55:54.490593+00
86	Tanvi Patel	contact086@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-06 17:55:54.490593+00
87	Amit Deshmukh	contact087@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-06 12:55:54.490593+00
88	Lakshmi Menon	contact088@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-06 07:55:54.490593+00
89	Thomas Kapoor	contact089@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-06 02:55:54.490593+00
90	Swati Naidu	contact090@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-05 21:55:54.490593+00
91	Vivaan Saxena	contact091@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-05 16:55:54.490593+00
92	Sneha Iyer	contact092@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-05 11:55:54.490593+00
93	Zoya Patil	contact093@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-05 06:55:54.490593+00
94	Hitesh Banerjee	contact094@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-05 01:55:54.490593+00
95	Isha Chauhan	contact095@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-04 20:55:54.490593+00
96	Rahul Hegde	contact096@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-04 15:55:54.490593+00
97	Meena Bose	contact097@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-04 10:55:54.490593+00
98	Mary Reddy	contact098@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-04 05:55:54.490593+00
99	Manoj Gill	contact099@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-04 00:55:54.490593+00
100	Aarav Mehta	contact100@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-03 19:55:54.490593+00
101	Ananya Mishra	contact101@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-03 14:55:54.490593+00
102	Ayesha Fernandes	contact102@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-11-03 09:55:54.490593+00
103	Prakash Verma	contact103@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-11-03 04:55:54.490593+00
104	Shreya Kulkarni	contact104@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-11-02 23:55:54.490593+00
105	Karan Qureshi	contact105@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-11-02 18:55:54.490593+00
106	Divya Gupta	contact106@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-11-02 13:55:54.490593+00
107	Joseph Das	contact107@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-11-02 08:55:54.490593+00
108	Sunil Thakur	contact108@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-11-02 03:55:54.490593+00
109	Geeta Shah	contact109@demo.forgetrace.in	Bulk RFQ question	Can one RFQ be split across two suppliers for a monthly quantity of 20,000 parts?	NEW	2026-11-01 22:55:54.490593+00
110	Priya Joshi	contact110@demo.forgetrace.in	Passport for export shipment	Our customer wants batch traceability. Can we add material certificates to the passport?	IN_PROGRESS	2026-11-01 17:55:54.490593+00
111	Farhan Pillai	contact111@demo.forgetrace.in	GST invoice	Please confirm whether platform fees will have a GST invoice with our GSTIN.	RESOLVED	2026-11-01 12:55:54.490593+00
112	Nitin Malhotra	contact112@demo.forgetrace.in	API access	Do you offer an API so our ERP can push RFQs automatically?	NEW	2026-11-01 07:55:54.490593+00
113	Anjali Gowda	contact113@demo.forgetrace.in	Verification taking long	We registered a few days ago and are still pending. What else is required?	NEW	2026-11-01 02:55:54.490593+00
114	Rohan Sinha	contact114@demo.forgetrace.in	Inspection partnership	We are an accredited lab and would like to be listed as an inspection partner.	IN_PROGRESS	2026-10-31 21:55:54.490593+00
115	Kavya Nair	contact115@demo.forgetrace.in	Student project	Can our college lab use ForgeTrace for a capstone project?	RESOLVED	2026-10-31 16:55:54.490593+00
116	Manpreet Singh	contact116@demo.forgetrace.in	Payment options	Do you support NEFT or RTGS for large orders?	NEW	2026-10-31 11:55:54.490593+00
117	Arun Chatterjee	contact117@demo.forgetrace.in	Edit my profile	I selected the wrong materials while registering. How do I edit them?	NEW	2026-10-31 06:55:54.490593+00
118	Rekha Yadav	contact118@demo.forgetrace.in	Recall notification	We received a recall notice for a batch. Who should we contact for replacement?	IN_PROGRESS	2026-10-31 01:55:54.490593+00
119	Ramesh Bhat	contact119@demo.forgetrace.in	Feature request	The quotation comparison page is very useful. Please add a lead-time filter.	RESOLVED	2026-10-30 20:55:54.490593+00
120	Imran Sharma	contact120@demo.forgetrace.in	Onboarding our machine shop	We would like to register several units from our cluster. What documents do you need?	NEW	2026-10-30 15:55:54.490593+00
\.


--
-- Data for Name: disputes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.disputes (id, order_id, opened_by, reason, description, status, resolution, resolved_by, resolved_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: file_objects; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.file_objects (id, bucket, object_key, original_filename, content_type, size_bytes, uploaded_by, organization_id, created_at) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	identity	SQL	V1__identity.sql	-1682425712	forgetrace	2026-11-24 09:58:33.277865	139	t
2	2	directory	SQL	V2__directory.sql	1647112166	forgetrace	2026-11-24 09:58:33.493122	118	t
3	3	marketplace	SQL	V3__marketplace.sql	-170428403	forgetrace	2026-11-24 09:58:33.650922	152	t
4	4	production	SQL	V4__production.sql	-1606609740	forgetrace	2026-11-24 09:58:33.853474	415	t
5	5	quality	SQL	V5__quality.sql	575687054	forgetrace	2026-11-24 09:58:34.317527	82	t
6	6	commerce	SQL	V6__commerce.sql	1092976055	forgetrace	2026-11-24 09:58:34.448796	94	t
7	7	operations	SQL	V7__operations.sql	374590347	forgetrace	2026-11-24 09:58:34.592646	148	t
8	8	seed reference data	SQL	V8__seed_reference_data.sql	1825497005	forgetrace	2026-11-24 09:58:34.786636	23	t
\.


--
-- Data for Name: inspection_measurements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inspection_measurements (id, inspection_id, parameter_name, expected_min, expected_max, actual_value, unit, result, remarks) FROM stdin;
\.


--
-- Data for Name: inspections; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inspections (id, batch_id, inspector_user_id, inspection_type, status, findings, inspected_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: machine_availability_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.machine_availability_rules (id, machine_id, day_of_week, start_time, end_time, valid_from, valid_until, active) FROM stdin;
1	1	1	09:00:00	18:00:00	2026-10-25	\N	t
2	1	2	09:00:00	18:00:00	2026-10-25	\N	t
3	1	3	09:00:00	18:00:00	2026-10-25	\N	t
4	1	4	09:00:00	18:00:00	2026-10-25	\N	t
5	1	5	09:00:00	18:00:00	2026-10-25	\N	t
6	1	6	09:00:00	18:00:00	2026-10-25	\N	t
7	2	1	06:00:00	22:00:00	2026-10-25	\N	t
8	2	2	06:00:00	22:00:00	2026-10-25	\N	t
9	2	3	06:00:00	22:00:00	2026-10-25	\N	t
10	2	4	06:00:00	22:00:00	2026-10-25	\N	t
11	2	5	06:00:00	22:00:00	2026-10-25	\N	t
12	3	1	09:00:00	18:00:00	2026-10-25	\N	t
13	3	2	09:00:00	18:00:00	2026-10-25	\N	t
14	3	3	09:00:00	18:00:00	2026-10-25	\N	t
15	3	4	09:00:00	18:00:00	2026-10-25	\N	t
16	3	5	09:00:00	18:00:00	2026-10-25	\N	t
17	3	6	09:00:00	18:00:00	2026-10-25	\N	t
18	4	1	06:00:00	22:00:00	2026-10-25	\N	t
19	4	2	06:00:00	22:00:00	2026-10-25	\N	t
20	4	3	06:00:00	22:00:00	2026-10-25	\N	t
21	4	4	06:00:00	22:00:00	2026-10-25	\N	t
22	4	5	06:00:00	22:00:00	2026-10-25	\N	t
23	5	1	09:00:00	18:00:00	2026-10-25	\N	t
24	5	2	09:00:00	18:00:00	2026-10-25	\N	t
25	5	3	09:00:00	18:00:00	2026-10-25	\N	t
26	5	4	09:00:00	18:00:00	2026-10-25	\N	t
27	5	5	09:00:00	18:00:00	2026-10-25	\N	t
28	5	6	09:00:00	18:00:00	2026-10-25	\N	t
29	6	1	06:00:00	22:00:00	2026-10-25	\N	t
30	6	2	06:00:00	22:00:00	2026-10-25	\N	t
31	6	3	06:00:00	22:00:00	2026-10-25	\N	t
32	6	4	06:00:00	22:00:00	2026-10-25	\N	t
33	6	5	06:00:00	22:00:00	2026-10-25	\N	t
34	7	1	09:00:00	18:00:00	2026-10-25	\N	t
35	7	2	09:00:00	18:00:00	2026-10-25	\N	t
36	7	3	09:00:00	18:00:00	2026-10-25	\N	t
37	7	4	09:00:00	18:00:00	2026-10-25	\N	t
38	7	5	09:00:00	18:00:00	2026-10-25	\N	t
39	7	6	09:00:00	18:00:00	2026-10-25	\N	t
40	8	1	06:00:00	22:00:00	2026-10-25	\N	t
41	8	2	06:00:00	22:00:00	2026-10-25	\N	t
42	8	3	06:00:00	22:00:00	2026-10-25	\N	t
43	8	4	06:00:00	22:00:00	2026-10-25	\N	t
44	8	5	06:00:00	22:00:00	2026-10-25	\N	t
45	9	1	09:00:00	18:00:00	2026-10-25	\N	t
46	9	2	09:00:00	18:00:00	2026-10-25	\N	t
47	9	3	09:00:00	18:00:00	2026-10-25	\N	t
48	9	4	09:00:00	18:00:00	2026-10-25	\N	t
49	9	5	09:00:00	18:00:00	2026-10-25	\N	t
50	9	6	09:00:00	18:00:00	2026-10-25	\N	t
51	10	1	09:00:00	18:00:00	2026-10-25	\N	t
52	10	2	09:00:00	18:00:00	2026-10-25	\N	t
53	10	3	09:00:00	18:00:00	2026-10-25	\N	t
54	10	4	09:00:00	18:00:00	2026-10-25	\N	t
55	10	5	09:00:00	18:00:00	2026-10-25	\N	t
56	10	6	09:00:00	18:00:00	2026-10-25	\N	t
57	11	1	06:00:00	22:00:00	2026-10-25	\N	t
58	11	2	06:00:00	22:00:00	2026-10-25	\N	t
59	11	3	06:00:00	22:00:00	2026-10-25	\N	t
60	11	4	06:00:00	22:00:00	2026-10-25	\N	t
61	11	5	06:00:00	22:00:00	2026-10-25	\N	t
62	12	1	09:00:00	18:00:00	2026-10-25	\N	t
63	12	2	09:00:00	18:00:00	2026-10-25	\N	t
64	12	3	09:00:00	18:00:00	2026-10-25	\N	t
65	12	4	09:00:00	18:00:00	2026-10-25	\N	t
66	12	5	09:00:00	18:00:00	2026-10-25	\N	t
67	12	6	09:00:00	18:00:00	2026-10-25	\N	t
68	13	1	09:00:00	18:00:00	2026-10-25	\N	t
69	13	2	09:00:00	18:00:00	2026-10-25	\N	t
70	13	3	09:00:00	18:00:00	2026-10-25	\N	t
71	13	4	09:00:00	18:00:00	2026-10-25	\N	t
72	13	5	09:00:00	18:00:00	2026-10-25	\N	t
73	13	6	09:00:00	18:00:00	2026-10-25	\N	t
74	14	1	06:00:00	22:00:00	2026-10-25	\N	t
75	14	2	06:00:00	22:00:00	2026-10-25	\N	t
76	14	3	06:00:00	22:00:00	2026-10-25	\N	t
77	14	4	06:00:00	22:00:00	2026-10-25	\N	t
78	14	5	06:00:00	22:00:00	2026-10-25	\N	t
79	15	1	09:00:00	18:00:00	2026-10-25	\N	t
80	15	2	09:00:00	18:00:00	2026-10-25	\N	t
81	15	3	09:00:00	18:00:00	2026-10-25	\N	t
82	15	4	09:00:00	18:00:00	2026-10-25	\N	t
83	15	5	09:00:00	18:00:00	2026-10-25	\N	t
84	15	6	09:00:00	18:00:00	2026-10-25	\N	t
85	16	1	06:00:00	22:00:00	2026-10-25	\N	t
86	16	2	06:00:00	22:00:00	2026-10-25	\N	t
87	16	3	06:00:00	22:00:00	2026-10-25	\N	t
88	16	4	06:00:00	22:00:00	2026-10-25	\N	t
89	16	5	06:00:00	22:00:00	2026-10-25	\N	t
90	17	1	09:00:00	18:00:00	2026-10-25	\N	t
91	17	2	09:00:00	18:00:00	2026-10-25	\N	t
92	17	3	09:00:00	18:00:00	2026-10-25	\N	t
93	17	4	09:00:00	18:00:00	2026-10-25	\N	t
94	17	5	09:00:00	18:00:00	2026-10-25	\N	t
95	17	6	09:00:00	18:00:00	2026-10-25	\N	t
96	18	1	06:00:00	22:00:00	2026-10-25	\N	t
97	18	2	06:00:00	22:00:00	2026-10-25	\N	t
98	18	3	06:00:00	22:00:00	2026-10-25	\N	t
99	18	4	06:00:00	22:00:00	2026-10-25	\N	t
100	18	5	06:00:00	22:00:00	2026-10-25	\N	t
101	19	1	09:00:00	18:00:00	2026-10-25	\N	t
102	19	2	09:00:00	18:00:00	2026-10-25	\N	t
103	19	3	09:00:00	18:00:00	2026-10-25	\N	t
104	19	4	09:00:00	18:00:00	2026-10-25	\N	t
105	19	5	09:00:00	18:00:00	2026-10-25	\N	t
106	19	6	09:00:00	18:00:00	2026-10-25	\N	t
107	20	1	06:00:00	22:00:00	2026-10-25	\N	t
108	20	2	06:00:00	22:00:00	2026-10-25	\N	t
109	20	3	06:00:00	22:00:00	2026-10-25	\N	t
110	20	4	06:00:00	22:00:00	2026-10-25	\N	t
111	20	5	06:00:00	22:00:00	2026-10-25	\N	t
112	21	1	09:00:00	18:00:00	2026-10-25	\N	t
113	21	2	09:00:00	18:00:00	2026-10-25	\N	t
114	21	3	09:00:00	18:00:00	2026-10-25	\N	t
115	21	4	09:00:00	18:00:00	2026-10-25	\N	t
116	21	5	09:00:00	18:00:00	2026-10-25	\N	t
117	21	6	09:00:00	18:00:00	2026-10-25	\N	t
118	22	1	09:00:00	18:00:00	2026-10-25	\N	t
119	22	2	09:00:00	18:00:00	2026-10-25	\N	t
120	22	3	09:00:00	18:00:00	2026-10-25	\N	t
121	22	4	09:00:00	18:00:00	2026-10-25	\N	t
122	22	5	09:00:00	18:00:00	2026-10-25	\N	t
123	22	6	09:00:00	18:00:00	2026-10-25	\N	t
124	23	1	06:00:00	22:00:00	2026-10-25	\N	t
125	23	2	06:00:00	22:00:00	2026-10-25	\N	t
126	23	3	06:00:00	22:00:00	2026-10-25	\N	t
127	23	4	06:00:00	22:00:00	2026-10-25	\N	t
128	23	5	06:00:00	22:00:00	2026-10-25	\N	t
129	24	1	09:00:00	18:00:00	2026-10-25	\N	t
130	24	2	09:00:00	18:00:00	2026-10-25	\N	t
131	24	3	09:00:00	18:00:00	2026-10-25	\N	t
132	24	4	09:00:00	18:00:00	2026-10-25	\N	t
133	24	5	09:00:00	18:00:00	2026-10-25	\N	t
134	24	6	09:00:00	18:00:00	2026-10-25	\N	t
135	25	1	09:00:00	18:00:00	2026-10-25	\N	t
136	25	2	09:00:00	18:00:00	2026-10-25	\N	t
137	25	3	09:00:00	18:00:00	2026-10-25	\N	t
138	25	4	09:00:00	18:00:00	2026-10-25	\N	t
139	25	5	09:00:00	18:00:00	2026-10-25	\N	t
140	25	6	09:00:00	18:00:00	2026-10-25	\N	t
141	26	1	06:00:00	22:00:00	2026-10-25	\N	t
142	26	2	06:00:00	22:00:00	2026-10-25	\N	t
143	26	3	06:00:00	22:00:00	2026-10-25	\N	t
144	26	4	06:00:00	22:00:00	2026-10-25	\N	t
145	26	5	06:00:00	22:00:00	2026-10-25	\N	t
146	27	1	09:00:00	18:00:00	2026-10-25	\N	t
147	27	2	09:00:00	18:00:00	2026-10-25	\N	t
148	27	3	09:00:00	18:00:00	2026-10-25	\N	t
149	27	4	09:00:00	18:00:00	2026-10-25	\N	t
150	27	5	09:00:00	18:00:00	2026-10-25	\N	t
151	27	6	09:00:00	18:00:00	2026-10-25	\N	t
152	28	1	06:00:00	22:00:00	2026-10-25	\N	t
153	28	2	06:00:00	22:00:00	2026-10-25	\N	t
154	28	3	06:00:00	22:00:00	2026-10-25	\N	t
155	28	4	06:00:00	22:00:00	2026-10-25	\N	t
156	28	5	06:00:00	22:00:00	2026-10-25	\N	t
157	29	1	09:00:00	18:00:00	2026-10-25	\N	t
158	29	2	09:00:00	18:00:00	2026-10-25	\N	t
159	29	3	09:00:00	18:00:00	2026-10-25	\N	t
160	29	4	09:00:00	18:00:00	2026-10-25	\N	t
161	29	5	09:00:00	18:00:00	2026-10-25	\N	t
162	29	6	09:00:00	18:00:00	2026-10-25	\N	t
163	30	1	06:00:00	22:00:00	2026-10-25	\N	t
164	30	2	06:00:00	22:00:00	2026-10-25	\N	t
165	30	3	06:00:00	22:00:00	2026-10-25	\N	t
166	30	4	06:00:00	22:00:00	2026-10-25	\N	t
167	30	5	06:00:00	22:00:00	2026-10-25	\N	t
168	31	1	09:00:00	18:00:00	2026-10-25	\N	t
169	31	2	09:00:00	18:00:00	2026-10-25	\N	t
170	31	3	09:00:00	18:00:00	2026-10-25	\N	t
171	31	4	09:00:00	18:00:00	2026-10-25	\N	t
172	31	5	09:00:00	18:00:00	2026-10-25	\N	t
173	31	6	09:00:00	18:00:00	2026-10-25	\N	t
174	32	1	06:00:00	22:00:00	2026-10-25	\N	t
175	32	2	06:00:00	22:00:00	2026-10-25	\N	t
176	32	3	06:00:00	22:00:00	2026-10-25	\N	t
177	32	4	06:00:00	22:00:00	2026-10-25	\N	t
178	32	5	06:00:00	22:00:00	2026-10-25	\N	t
179	33	1	09:00:00	18:00:00	2026-10-25	\N	t
180	33	2	09:00:00	18:00:00	2026-10-25	\N	t
181	33	3	09:00:00	18:00:00	2026-10-25	\N	t
182	33	4	09:00:00	18:00:00	2026-10-25	\N	t
183	33	5	09:00:00	18:00:00	2026-10-25	\N	t
184	33	6	09:00:00	18:00:00	2026-10-25	\N	t
185	34	1	09:00:00	18:00:00	2026-10-25	\N	t
186	34	2	09:00:00	18:00:00	2026-10-25	\N	t
187	34	3	09:00:00	18:00:00	2026-10-25	\N	t
188	34	4	09:00:00	18:00:00	2026-10-25	\N	t
189	34	5	09:00:00	18:00:00	2026-10-25	\N	t
190	34	6	09:00:00	18:00:00	2026-10-25	\N	t
191	35	1	06:00:00	22:00:00	2026-10-25	\N	t
192	35	2	06:00:00	22:00:00	2026-10-25	\N	t
193	35	3	06:00:00	22:00:00	2026-10-25	\N	t
194	35	4	06:00:00	22:00:00	2026-10-25	\N	t
195	35	5	06:00:00	22:00:00	2026-10-25	\N	t
196	36	1	09:00:00	18:00:00	2026-10-25	\N	t
197	36	2	09:00:00	18:00:00	2026-10-25	\N	t
198	36	3	09:00:00	18:00:00	2026-10-25	\N	t
199	36	4	09:00:00	18:00:00	2026-10-25	\N	t
200	36	5	09:00:00	18:00:00	2026-10-25	\N	t
201	36	6	09:00:00	18:00:00	2026-10-25	\N	t
202	37	1	09:00:00	18:00:00	2026-10-25	\N	t
203	37	2	09:00:00	18:00:00	2026-10-25	\N	t
204	37	3	09:00:00	18:00:00	2026-10-25	\N	t
205	37	4	09:00:00	18:00:00	2026-10-25	\N	t
206	37	5	09:00:00	18:00:00	2026-10-25	\N	t
207	37	6	09:00:00	18:00:00	2026-10-25	\N	t
208	38	1	06:00:00	22:00:00	2026-10-25	\N	t
209	38	2	06:00:00	22:00:00	2026-10-25	\N	t
210	38	3	06:00:00	22:00:00	2026-10-25	\N	t
211	38	4	06:00:00	22:00:00	2026-10-25	\N	t
212	38	5	06:00:00	22:00:00	2026-10-25	\N	t
213	39	1	09:00:00	18:00:00	2026-10-25	\N	t
214	39	2	09:00:00	18:00:00	2026-10-25	\N	t
215	39	3	09:00:00	18:00:00	2026-10-25	\N	t
216	39	4	09:00:00	18:00:00	2026-10-25	\N	t
217	39	5	09:00:00	18:00:00	2026-10-25	\N	t
218	39	6	09:00:00	18:00:00	2026-10-25	\N	t
219	40	1	06:00:00	22:00:00	2026-10-25	\N	t
220	40	2	06:00:00	22:00:00	2026-10-25	\N	t
221	40	3	06:00:00	22:00:00	2026-10-25	\N	t
222	40	4	06:00:00	22:00:00	2026-10-25	\N	t
223	40	5	06:00:00	22:00:00	2026-10-25	\N	t
224	41	1	09:00:00	18:00:00	2026-10-25	\N	t
225	41	2	09:00:00	18:00:00	2026-10-25	\N	t
226	41	3	09:00:00	18:00:00	2026-10-25	\N	t
227	41	4	09:00:00	18:00:00	2026-10-25	\N	t
228	41	5	09:00:00	18:00:00	2026-10-25	\N	t
229	41	6	09:00:00	18:00:00	2026-10-25	\N	t
230	42	1	06:00:00	22:00:00	2026-10-25	\N	t
231	42	2	06:00:00	22:00:00	2026-10-25	\N	t
232	42	3	06:00:00	22:00:00	2026-10-25	\N	t
233	42	4	06:00:00	22:00:00	2026-10-25	\N	t
234	42	5	06:00:00	22:00:00	2026-10-25	\N	t
235	43	1	09:00:00	18:00:00	2026-10-25	\N	t
236	43	2	09:00:00	18:00:00	2026-10-25	\N	t
237	43	3	09:00:00	18:00:00	2026-10-25	\N	t
238	43	4	09:00:00	18:00:00	2026-10-25	\N	t
239	43	5	09:00:00	18:00:00	2026-10-25	\N	t
240	43	6	09:00:00	18:00:00	2026-10-25	\N	t
241	44	1	06:00:00	22:00:00	2026-10-25	\N	t
242	44	2	06:00:00	22:00:00	2026-10-25	\N	t
243	44	3	06:00:00	22:00:00	2026-10-25	\N	t
244	44	4	06:00:00	22:00:00	2026-10-25	\N	t
245	44	5	06:00:00	22:00:00	2026-10-25	\N	t
246	45	1	09:00:00	18:00:00	2026-10-25	\N	t
247	45	2	09:00:00	18:00:00	2026-10-25	\N	t
248	45	3	09:00:00	18:00:00	2026-10-25	\N	t
249	45	4	09:00:00	18:00:00	2026-10-25	\N	t
250	45	5	09:00:00	18:00:00	2026-10-25	\N	t
251	45	6	09:00:00	18:00:00	2026-10-25	\N	t
252	46	1	09:00:00	18:00:00	2026-10-25	\N	t
253	46	2	09:00:00	18:00:00	2026-10-25	\N	t
254	46	3	09:00:00	18:00:00	2026-10-25	\N	t
255	46	4	09:00:00	18:00:00	2026-10-25	\N	t
256	46	5	09:00:00	18:00:00	2026-10-25	\N	t
257	46	6	09:00:00	18:00:00	2026-10-25	\N	t
258	47	1	06:00:00	22:00:00	2026-10-25	\N	t
259	47	2	06:00:00	22:00:00	2026-10-25	\N	t
260	47	3	06:00:00	22:00:00	2026-10-25	\N	t
261	47	4	06:00:00	22:00:00	2026-10-25	\N	t
262	47	5	06:00:00	22:00:00	2026-10-25	\N	t
263	48	1	09:00:00	18:00:00	2026-10-25	\N	t
264	48	2	09:00:00	18:00:00	2026-10-25	\N	t
265	48	3	09:00:00	18:00:00	2026-10-25	\N	t
266	48	4	09:00:00	18:00:00	2026-10-25	\N	t
267	48	5	09:00:00	18:00:00	2026-10-25	\N	t
268	48	6	09:00:00	18:00:00	2026-10-25	\N	t
269	49	1	09:00:00	18:00:00	2026-10-25	\N	t
270	49	2	09:00:00	18:00:00	2026-10-25	\N	t
271	49	3	09:00:00	18:00:00	2026-10-25	\N	t
272	49	4	09:00:00	18:00:00	2026-10-25	\N	t
273	49	5	09:00:00	18:00:00	2026-10-25	\N	t
274	49	6	09:00:00	18:00:00	2026-10-25	\N	t
275	50	1	06:00:00	22:00:00	2026-10-25	\N	t
276	50	2	06:00:00	22:00:00	2026-10-25	\N	t
277	50	3	06:00:00	22:00:00	2026-10-25	\N	t
278	50	4	06:00:00	22:00:00	2026-10-25	\N	t
279	50	5	06:00:00	22:00:00	2026-10-25	\N	t
280	51	1	09:00:00	18:00:00	2026-10-25	\N	t
281	51	2	09:00:00	18:00:00	2026-10-25	\N	t
282	51	3	09:00:00	18:00:00	2026-10-25	\N	t
283	51	4	09:00:00	18:00:00	2026-10-25	\N	t
284	51	5	09:00:00	18:00:00	2026-10-25	\N	t
285	51	6	09:00:00	18:00:00	2026-10-25	\N	t
286	52	1	06:00:00	22:00:00	2026-10-25	\N	t
287	52	2	06:00:00	22:00:00	2026-10-25	\N	t
288	52	3	06:00:00	22:00:00	2026-10-25	\N	t
289	52	4	06:00:00	22:00:00	2026-10-25	\N	t
290	52	5	06:00:00	22:00:00	2026-10-25	\N	t
291	53	1	09:00:00	18:00:00	2026-10-25	\N	t
292	53	2	09:00:00	18:00:00	2026-10-25	\N	t
293	53	3	09:00:00	18:00:00	2026-10-25	\N	t
294	53	4	09:00:00	18:00:00	2026-10-25	\N	t
295	53	5	09:00:00	18:00:00	2026-10-25	\N	t
296	53	6	09:00:00	18:00:00	2026-10-25	\N	t
297	54	1	06:00:00	22:00:00	2026-10-25	\N	t
298	54	2	06:00:00	22:00:00	2026-10-25	\N	t
299	54	3	06:00:00	22:00:00	2026-10-25	\N	t
300	54	4	06:00:00	22:00:00	2026-10-25	\N	t
301	54	5	06:00:00	22:00:00	2026-10-25	\N	t
302	55	1	09:00:00	18:00:00	2026-10-25	\N	t
303	55	2	09:00:00	18:00:00	2026-10-25	\N	t
304	55	3	09:00:00	18:00:00	2026-10-25	\N	t
305	55	4	09:00:00	18:00:00	2026-10-25	\N	t
306	55	5	09:00:00	18:00:00	2026-10-25	\N	t
307	55	6	09:00:00	18:00:00	2026-10-25	\N	t
308	56	1	06:00:00	22:00:00	2026-10-25	\N	t
309	56	2	06:00:00	22:00:00	2026-10-25	\N	t
310	56	3	06:00:00	22:00:00	2026-10-25	\N	t
311	56	4	06:00:00	22:00:00	2026-10-25	\N	t
312	56	5	06:00:00	22:00:00	2026-10-25	\N	t
313	57	1	09:00:00	18:00:00	2026-10-25	\N	t
314	57	2	09:00:00	18:00:00	2026-10-25	\N	t
315	57	3	09:00:00	18:00:00	2026-10-25	\N	t
316	57	4	09:00:00	18:00:00	2026-10-25	\N	t
317	57	5	09:00:00	18:00:00	2026-10-25	\N	t
318	57	6	09:00:00	18:00:00	2026-10-25	\N	t
319	58	1	09:00:00	18:00:00	2026-10-25	\N	t
320	58	2	09:00:00	18:00:00	2026-10-25	\N	t
321	58	3	09:00:00	18:00:00	2026-10-25	\N	t
322	58	4	09:00:00	18:00:00	2026-10-25	\N	t
323	58	5	09:00:00	18:00:00	2026-10-25	\N	t
324	58	6	09:00:00	18:00:00	2026-10-25	\N	t
325	59	1	06:00:00	22:00:00	2026-10-25	\N	t
326	59	2	06:00:00	22:00:00	2026-10-25	\N	t
327	59	3	06:00:00	22:00:00	2026-10-25	\N	t
328	59	4	06:00:00	22:00:00	2026-10-25	\N	t
329	59	5	06:00:00	22:00:00	2026-10-25	\N	t
330	60	1	09:00:00	18:00:00	2026-10-25	\N	t
331	60	2	09:00:00	18:00:00	2026-10-25	\N	t
332	60	3	09:00:00	18:00:00	2026-10-25	\N	t
333	60	4	09:00:00	18:00:00	2026-10-25	\N	t
334	60	5	09:00:00	18:00:00	2026-10-25	\N	t
335	60	6	09:00:00	18:00:00	2026-10-25	\N	t
336	61	1	09:00:00	18:00:00	2026-10-25	\N	t
337	61	2	09:00:00	18:00:00	2026-10-25	\N	t
338	61	3	09:00:00	18:00:00	2026-10-25	\N	t
339	61	4	09:00:00	18:00:00	2026-10-25	\N	t
340	61	5	09:00:00	18:00:00	2026-10-25	\N	t
341	61	6	09:00:00	18:00:00	2026-10-25	\N	t
342	62	1	06:00:00	22:00:00	2026-10-25	\N	t
343	62	2	06:00:00	22:00:00	2026-10-25	\N	t
344	62	3	06:00:00	22:00:00	2026-10-25	\N	t
345	62	4	06:00:00	22:00:00	2026-10-25	\N	t
346	62	5	06:00:00	22:00:00	2026-10-25	\N	t
347	63	1	09:00:00	18:00:00	2026-10-25	\N	t
348	63	2	09:00:00	18:00:00	2026-10-25	\N	t
349	63	3	09:00:00	18:00:00	2026-10-25	\N	t
350	63	4	09:00:00	18:00:00	2026-10-25	\N	t
351	63	5	09:00:00	18:00:00	2026-10-25	\N	t
352	63	6	09:00:00	18:00:00	2026-10-25	\N	t
353	64	1	06:00:00	22:00:00	2026-10-25	\N	t
354	64	2	06:00:00	22:00:00	2026-10-25	\N	t
355	64	3	06:00:00	22:00:00	2026-10-25	\N	t
356	64	4	06:00:00	22:00:00	2026-10-25	\N	t
357	64	5	06:00:00	22:00:00	2026-10-25	\N	t
358	65	1	09:00:00	18:00:00	2026-10-25	\N	t
359	65	2	09:00:00	18:00:00	2026-10-25	\N	t
360	65	3	09:00:00	18:00:00	2026-10-25	\N	t
361	65	4	09:00:00	18:00:00	2026-10-25	\N	t
362	65	5	09:00:00	18:00:00	2026-10-25	\N	t
363	65	6	09:00:00	18:00:00	2026-10-25	\N	t
364	66	1	06:00:00	22:00:00	2026-10-25	\N	t
365	66	2	06:00:00	22:00:00	2026-10-25	\N	t
366	66	3	06:00:00	22:00:00	2026-10-25	\N	t
367	66	4	06:00:00	22:00:00	2026-10-25	\N	t
368	66	5	06:00:00	22:00:00	2026-10-25	\N	t
369	67	1	09:00:00	18:00:00	2026-10-25	\N	t
370	67	2	09:00:00	18:00:00	2026-10-25	\N	t
371	67	3	09:00:00	18:00:00	2026-10-25	\N	t
372	67	4	09:00:00	18:00:00	2026-10-25	\N	t
373	67	5	09:00:00	18:00:00	2026-10-25	\N	t
374	67	6	09:00:00	18:00:00	2026-10-25	\N	t
375	68	1	06:00:00	22:00:00	2026-10-25	\N	t
376	68	2	06:00:00	22:00:00	2026-10-25	\N	t
377	68	3	06:00:00	22:00:00	2026-10-25	\N	t
378	68	4	06:00:00	22:00:00	2026-10-25	\N	t
379	68	5	06:00:00	22:00:00	2026-10-25	\N	t
380	69	1	09:00:00	18:00:00	2026-10-25	\N	t
381	69	2	09:00:00	18:00:00	2026-10-25	\N	t
382	69	3	09:00:00	18:00:00	2026-10-25	\N	t
383	69	4	09:00:00	18:00:00	2026-10-25	\N	t
384	69	5	09:00:00	18:00:00	2026-10-25	\N	t
385	69	6	09:00:00	18:00:00	2026-10-25	\N	t
386	70	1	09:00:00	18:00:00	2026-10-25	\N	t
387	70	2	09:00:00	18:00:00	2026-10-25	\N	t
388	70	3	09:00:00	18:00:00	2026-10-25	\N	t
389	70	4	09:00:00	18:00:00	2026-10-25	\N	t
390	70	5	09:00:00	18:00:00	2026-10-25	\N	t
391	70	6	09:00:00	18:00:00	2026-10-25	\N	t
392	71	1	06:00:00	22:00:00	2026-10-25	\N	t
393	71	2	06:00:00	22:00:00	2026-10-25	\N	t
394	71	3	06:00:00	22:00:00	2026-10-25	\N	t
395	71	4	06:00:00	22:00:00	2026-10-25	\N	t
396	71	5	06:00:00	22:00:00	2026-10-25	\N	t
397	72	1	09:00:00	18:00:00	2026-10-25	\N	t
398	72	2	09:00:00	18:00:00	2026-10-25	\N	t
399	72	3	09:00:00	18:00:00	2026-10-25	\N	t
400	72	4	09:00:00	18:00:00	2026-10-25	\N	t
401	72	5	09:00:00	18:00:00	2026-10-25	\N	t
402	72	6	09:00:00	18:00:00	2026-10-25	\N	t
403	73	1	09:00:00	18:00:00	2026-10-25	\N	t
404	73	2	09:00:00	18:00:00	2026-10-25	\N	t
405	73	3	09:00:00	18:00:00	2026-10-25	\N	t
406	73	4	09:00:00	18:00:00	2026-10-25	\N	t
407	73	5	09:00:00	18:00:00	2026-10-25	\N	t
408	73	6	09:00:00	18:00:00	2026-10-25	\N	t
409	74	1	06:00:00	22:00:00	2026-10-25	\N	t
410	74	2	06:00:00	22:00:00	2026-10-25	\N	t
411	74	3	06:00:00	22:00:00	2026-10-25	\N	t
412	74	4	06:00:00	22:00:00	2026-10-25	\N	t
413	74	5	06:00:00	22:00:00	2026-10-25	\N	t
414	75	1	09:00:00	18:00:00	2026-10-25	\N	t
415	75	2	09:00:00	18:00:00	2026-10-25	\N	t
416	75	3	09:00:00	18:00:00	2026-10-25	\N	t
417	75	4	09:00:00	18:00:00	2026-10-25	\N	t
418	75	5	09:00:00	18:00:00	2026-10-25	\N	t
419	75	6	09:00:00	18:00:00	2026-10-25	\N	t
420	76	1	06:00:00	22:00:00	2026-10-25	\N	t
421	76	2	06:00:00	22:00:00	2026-10-25	\N	t
422	76	3	06:00:00	22:00:00	2026-10-25	\N	t
423	76	4	06:00:00	22:00:00	2026-10-25	\N	t
424	76	5	06:00:00	22:00:00	2026-10-25	\N	t
425	77	1	09:00:00	18:00:00	2026-10-25	\N	t
426	77	2	09:00:00	18:00:00	2026-10-25	\N	t
427	77	3	09:00:00	18:00:00	2026-10-25	\N	t
428	77	4	09:00:00	18:00:00	2026-10-25	\N	t
429	77	5	09:00:00	18:00:00	2026-10-25	\N	t
430	77	6	09:00:00	18:00:00	2026-10-25	\N	t
431	78	1	06:00:00	22:00:00	2026-10-25	\N	t
432	78	2	06:00:00	22:00:00	2026-10-25	\N	t
433	78	3	06:00:00	22:00:00	2026-10-25	\N	t
434	78	4	06:00:00	22:00:00	2026-10-25	\N	t
435	78	5	06:00:00	22:00:00	2026-10-25	\N	t
436	79	1	09:00:00	18:00:00	2026-10-25	\N	t
437	79	2	09:00:00	18:00:00	2026-10-25	\N	t
438	79	3	09:00:00	18:00:00	2026-10-25	\N	t
439	79	4	09:00:00	18:00:00	2026-10-25	\N	t
440	79	5	09:00:00	18:00:00	2026-10-25	\N	t
441	79	6	09:00:00	18:00:00	2026-10-25	\N	t
442	80	1	06:00:00	22:00:00	2026-10-25	\N	t
443	80	2	06:00:00	22:00:00	2026-10-25	\N	t
444	80	3	06:00:00	22:00:00	2026-10-25	\N	t
445	80	4	06:00:00	22:00:00	2026-10-25	\N	t
446	80	5	06:00:00	22:00:00	2026-10-25	\N	t
447	81	1	09:00:00	18:00:00	2026-10-25	\N	t
448	81	2	09:00:00	18:00:00	2026-10-25	\N	t
449	81	3	09:00:00	18:00:00	2026-10-25	\N	t
450	81	4	09:00:00	18:00:00	2026-10-25	\N	t
451	81	5	09:00:00	18:00:00	2026-10-25	\N	t
452	81	6	09:00:00	18:00:00	2026-10-25	\N	t
453	82	1	09:00:00	18:00:00	2026-10-25	\N	t
454	82	2	09:00:00	18:00:00	2026-10-25	\N	t
455	82	3	09:00:00	18:00:00	2026-10-25	\N	t
456	82	4	09:00:00	18:00:00	2026-10-25	\N	t
457	82	5	09:00:00	18:00:00	2026-10-25	\N	t
458	82	6	09:00:00	18:00:00	2026-10-25	\N	t
459	83	1	06:00:00	22:00:00	2026-10-25	\N	t
460	83	2	06:00:00	22:00:00	2026-10-25	\N	t
461	83	3	06:00:00	22:00:00	2026-10-25	\N	t
462	83	4	06:00:00	22:00:00	2026-10-25	\N	t
463	83	5	06:00:00	22:00:00	2026-10-25	\N	t
464	84	1	09:00:00	18:00:00	2026-10-25	\N	t
465	84	2	09:00:00	18:00:00	2026-10-25	\N	t
466	84	3	09:00:00	18:00:00	2026-10-25	\N	t
467	84	4	09:00:00	18:00:00	2026-10-25	\N	t
468	84	5	09:00:00	18:00:00	2026-10-25	\N	t
469	84	6	09:00:00	18:00:00	2026-10-25	\N	t
470	85	1	09:00:00	18:00:00	2026-10-25	\N	t
471	85	2	09:00:00	18:00:00	2026-10-25	\N	t
472	85	3	09:00:00	18:00:00	2026-10-25	\N	t
473	85	4	09:00:00	18:00:00	2026-10-25	\N	t
474	85	5	09:00:00	18:00:00	2026-10-25	\N	t
475	85	6	09:00:00	18:00:00	2026-10-25	\N	t
476	86	1	06:00:00	22:00:00	2026-10-25	\N	t
477	86	2	06:00:00	22:00:00	2026-10-25	\N	t
478	86	3	06:00:00	22:00:00	2026-10-25	\N	t
479	86	4	06:00:00	22:00:00	2026-10-25	\N	t
480	86	5	06:00:00	22:00:00	2026-10-25	\N	t
481	87	1	09:00:00	18:00:00	2026-10-25	\N	t
482	87	2	09:00:00	18:00:00	2026-10-25	\N	t
483	87	3	09:00:00	18:00:00	2026-10-25	\N	t
484	87	4	09:00:00	18:00:00	2026-10-25	\N	t
485	87	5	09:00:00	18:00:00	2026-10-25	\N	t
486	87	6	09:00:00	18:00:00	2026-10-25	\N	t
487	88	1	06:00:00	22:00:00	2026-10-25	\N	t
488	88	2	06:00:00	22:00:00	2026-10-25	\N	t
489	88	3	06:00:00	22:00:00	2026-10-25	\N	t
490	88	4	06:00:00	22:00:00	2026-10-25	\N	t
491	88	5	06:00:00	22:00:00	2026-10-25	\N	t
492	89	1	09:00:00	18:00:00	2026-10-25	\N	t
493	89	2	09:00:00	18:00:00	2026-10-25	\N	t
494	89	3	09:00:00	18:00:00	2026-10-25	\N	t
495	89	4	09:00:00	18:00:00	2026-10-25	\N	t
496	89	5	09:00:00	18:00:00	2026-10-25	\N	t
497	89	6	09:00:00	18:00:00	2026-10-25	\N	t
498	90	1	06:00:00	22:00:00	2026-10-25	\N	t
499	90	2	06:00:00	22:00:00	2026-10-25	\N	t
500	90	3	06:00:00	22:00:00	2026-10-25	\N	t
501	90	4	06:00:00	22:00:00	2026-10-25	\N	t
502	90	5	06:00:00	22:00:00	2026-10-25	\N	t
503	91	1	09:00:00	18:00:00	2026-10-25	\N	t
504	91	2	09:00:00	18:00:00	2026-10-25	\N	t
505	91	3	09:00:00	18:00:00	2026-10-25	\N	t
506	91	4	09:00:00	18:00:00	2026-10-25	\N	t
507	91	5	09:00:00	18:00:00	2026-10-25	\N	t
508	91	6	09:00:00	18:00:00	2026-10-25	\N	t
509	92	1	06:00:00	22:00:00	2026-10-25	\N	t
510	92	2	06:00:00	22:00:00	2026-10-25	\N	t
511	92	3	06:00:00	22:00:00	2026-10-25	\N	t
512	92	4	06:00:00	22:00:00	2026-10-25	\N	t
513	92	5	06:00:00	22:00:00	2026-10-25	\N	t
514	93	1	09:00:00	18:00:00	2026-10-25	\N	t
515	93	2	09:00:00	18:00:00	2026-10-25	\N	t
516	93	3	09:00:00	18:00:00	2026-10-25	\N	t
517	93	4	09:00:00	18:00:00	2026-10-25	\N	t
518	93	5	09:00:00	18:00:00	2026-10-25	\N	t
519	93	6	09:00:00	18:00:00	2026-10-25	\N	t
520	94	1	09:00:00	18:00:00	2026-10-25	\N	t
521	94	2	09:00:00	18:00:00	2026-10-25	\N	t
522	94	3	09:00:00	18:00:00	2026-10-25	\N	t
523	94	4	09:00:00	18:00:00	2026-10-25	\N	t
524	94	5	09:00:00	18:00:00	2026-10-25	\N	t
525	94	6	09:00:00	18:00:00	2026-10-25	\N	t
526	95	1	06:00:00	22:00:00	2026-10-25	\N	t
527	95	2	06:00:00	22:00:00	2026-10-25	\N	t
528	95	3	06:00:00	22:00:00	2026-10-25	\N	t
529	95	4	06:00:00	22:00:00	2026-10-25	\N	t
530	95	5	06:00:00	22:00:00	2026-10-25	\N	t
531	96	1	09:00:00	18:00:00	2026-10-25	\N	t
532	96	2	09:00:00	18:00:00	2026-10-25	\N	t
533	96	3	09:00:00	18:00:00	2026-10-25	\N	t
534	96	4	09:00:00	18:00:00	2026-10-25	\N	t
535	96	5	09:00:00	18:00:00	2026-10-25	\N	t
536	96	6	09:00:00	18:00:00	2026-10-25	\N	t
537	97	1	09:00:00	18:00:00	2026-10-25	\N	t
538	97	2	09:00:00	18:00:00	2026-10-25	\N	t
539	97	3	09:00:00	18:00:00	2026-10-25	\N	t
540	97	4	09:00:00	18:00:00	2026-10-25	\N	t
541	97	5	09:00:00	18:00:00	2026-10-25	\N	t
542	97	6	09:00:00	18:00:00	2026-10-25	\N	t
543	98	1	06:00:00	22:00:00	2026-10-25	\N	t
544	98	2	06:00:00	22:00:00	2026-10-25	\N	t
545	98	3	06:00:00	22:00:00	2026-10-25	\N	t
546	98	4	06:00:00	22:00:00	2026-10-25	\N	t
547	98	5	06:00:00	22:00:00	2026-10-25	\N	t
548	99	1	09:00:00	18:00:00	2026-10-25	\N	t
549	99	2	09:00:00	18:00:00	2026-10-25	\N	t
550	99	3	09:00:00	18:00:00	2026-10-25	\N	t
551	99	4	09:00:00	18:00:00	2026-10-25	\N	t
552	99	5	09:00:00	18:00:00	2026-10-25	\N	t
553	99	6	09:00:00	18:00:00	2026-10-25	\N	t
554	100	1	06:00:00	22:00:00	2026-10-25	\N	t
555	100	2	06:00:00	22:00:00	2026-10-25	\N	t
556	100	3	06:00:00	22:00:00	2026-10-25	\N	t
557	100	4	06:00:00	22:00:00	2026-10-25	\N	t
558	100	5	06:00:00	22:00:00	2026-10-25	\N	t
559	101	1	09:00:00	18:00:00	2026-10-25	\N	t
560	101	2	09:00:00	18:00:00	2026-10-25	\N	t
561	101	3	09:00:00	18:00:00	2026-10-25	\N	t
562	101	4	09:00:00	18:00:00	2026-10-25	\N	t
563	101	5	09:00:00	18:00:00	2026-10-25	\N	t
564	101	6	09:00:00	18:00:00	2026-10-25	\N	t
565	102	1	06:00:00	22:00:00	2026-10-25	\N	t
566	102	2	06:00:00	22:00:00	2026-10-25	\N	t
567	102	3	06:00:00	22:00:00	2026-10-25	\N	t
568	102	4	06:00:00	22:00:00	2026-10-25	\N	t
569	102	5	06:00:00	22:00:00	2026-10-25	\N	t
570	103	1	09:00:00	18:00:00	2026-10-25	\N	t
571	103	2	09:00:00	18:00:00	2026-10-25	\N	t
572	103	3	09:00:00	18:00:00	2026-10-25	\N	t
573	103	4	09:00:00	18:00:00	2026-10-25	\N	t
574	103	5	09:00:00	18:00:00	2026-10-25	\N	t
575	103	6	09:00:00	18:00:00	2026-10-25	\N	t
576	104	1	06:00:00	22:00:00	2026-10-25	\N	t
577	104	2	06:00:00	22:00:00	2026-10-25	\N	t
578	104	3	06:00:00	22:00:00	2026-10-25	\N	t
579	104	4	06:00:00	22:00:00	2026-10-25	\N	t
580	104	5	06:00:00	22:00:00	2026-10-25	\N	t
581	105	1	09:00:00	18:00:00	2026-10-25	\N	t
582	105	2	09:00:00	18:00:00	2026-10-25	\N	t
583	105	3	09:00:00	18:00:00	2026-10-25	\N	t
584	105	4	09:00:00	18:00:00	2026-10-25	\N	t
585	105	5	09:00:00	18:00:00	2026-10-25	\N	t
586	105	6	09:00:00	18:00:00	2026-10-25	\N	t
587	106	1	09:00:00	18:00:00	2026-10-25	\N	t
588	106	2	09:00:00	18:00:00	2026-10-25	\N	t
589	106	3	09:00:00	18:00:00	2026-10-25	\N	t
590	106	4	09:00:00	18:00:00	2026-10-25	\N	t
591	106	5	09:00:00	18:00:00	2026-10-25	\N	t
592	106	6	09:00:00	18:00:00	2026-10-25	\N	t
593	107	1	06:00:00	22:00:00	2026-10-25	\N	t
594	107	2	06:00:00	22:00:00	2026-10-25	\N	t
595	107	3	06:00:00	22:00:00	2026-10-25	\N	t
596	107	4	06:00:00	22:00:00	2026-10-25	\N	t
597	107	5	06:00:00	22:00:00	2026-10-25	\N	t
598	108	1	09:00:00	18:00:00	2026-10-25	\N	t
599	108	2	09:00:00	18:00:00	2026-10-25	\N	t
600	108	3	09:00:00	18:00:00	2026-10-25	\N	t
601	108	4	09:00:00	18:00:00	2026-10-25	\N	t
602	108	5	09:00:00	18:00:00	2026-10-25	\N	t
603	108	6	09:00:00	18:00:00	2026-10-25	\N	t
604	109	1	09:00:00	18:00:00	2026-10-25	\N	t
605	109	2	09:00:00	18:00:00	2026-10-25	\N	t
606	109	3	09:00:00	18:00:00	2026-10-25	\N	t
607	109	4	09:00:00	18:00:00	2026-10-25	\N	t
608	109	5	09:00:00	18:00:00	2026-10-25	\N	t
609	109	6	09:00:00	18:00:00	2026-10-25	\N	t
610	110	1	06:00:00	22:00:00	2026-10-25	\N	t
611	110	2	06:00:00	22:00:00	2026-10-25	\N	t
612	110	3	06:00:00	22:00:00	2026-10-25	\N	t
613	110	4	06:00:00	22:00:00	2026-10-25	\N	t
614	110	5	06:00:00	22:00:00	2026-10-25	\N	t
615	111	1	09:00:00	18:00:00	2026-10-25	\N	t
616	111	2	09:00:00	18:00:00	2026-10-25	\N	t
617	111	3	09:00:00	18:00:00	2026-10-25	\N	t
618	111	4	09:00:00	18:00:00	2026-10-25	\N	t
619	111	5	09:00:00	18:00:00	2026-10-25	\N	t
620	111	6	09:00:00	18:00:00	2026-10-25	\N	t
621	112	1	06:00:00	22:00:00	2026-10-25	\N	t
622	112	2	06:00:00	22:00:00	2026-10-25	\N	t
623	112	3	06:00:00	22:00:00	2026-10-25	\N	t
624	112	4	06:00:00	22:00:00	2026-10-25	\N	t
625	112	5	06:00:00	22:00:00	2026-10-25	\N	t
626	113	1	09:00:00	18:00:00	2026-10-25	\N	t
627	113	2	09:00:00	18:00:00	2026-10-25	\N	t
628	113	3	09:00:00	18:00:00	2026-10-25	\N	t
629	113	4	09:00:00	18:00:00	2026-10-25	\N	t
630	113	5	09:00:00	18:00:00	2026-10-25	\N	t
631	113	6	09:00:00	18:00:00	2026-10-25	\N	t
632	114	1	06:00:00	22:00:00	2026-10-25	\N	t
633	114	2	06:00:00	22:00:00	2026-10-25	\N	t
634	114	3	06:00:00	22:00:00	2026-10-25	\N	t
635	114	4	06:00:00	22:00:00	2026-10-25	\N	t
636	114	5	06:00:00	22:00:00	2026-10-25	\N	t
637	115	1	09:00:00	18:00:00	2026-10-25	\N	t
638	115	2	09:00:00	18:00:00	2026-10-25	\N	t
639	115	3	09:00:00	18:00:00	2026-10-25	\N	t
640	115	4	09:00:00	18:00:00	2026-10-25	\N	t
641	115	5	09:00:00	18:00:00	2026-10-25	\N	t
642	115	6	09:00:00	18:00:00	2026-10-25	\N	t
643	116	1	06:00:00	22:00:00	2026-10-25	\N	t
644	116	2	06:00:00	22:00:00	2026-10-25	\N	t
645	116	3	06:00:00	22:00:00	2026-10-25	\N	t
646	116	4	06:00:00	22:00:00	2026-10-25	\N	t
647	116	5	06:00:00	22:00:00	2026-10-25	\N	t
648	117	1	09:00:00	18:00:00	2026-10-25	\N	t
649	117	2	09:00:00	18:00:00	2026-10-25	\N	t
650	117	3	09:00:00	18:00:00	2026-10-25	\N	t
651	117	4	09:00:00	18:00:00	2026-10-25	\N	t
652	117	5	09:00:00	18:00:00	2026-10-25	\N	t
653	117	6	09:00:00	18:00:00	2026-10-25	\N	t
654	118	1	09:00:00	18:00:00	2026-10-25	\N	t
655	118	2	09:00:00	18:00:00	2026-10-25	\N	t
656	118	3	09:00:00	18:00:00	2026-10-25	\N	t
657	118	4	09:00:00	18:00:00	2026-10-25	\N	t
658	118	5	09:00:00	18:00:00	2026-10-25	\N	t
659	118	6	09:00:00	18:00:00	2026-10-25	\N	t
660	119	1	06:00:00	22:00:00	2026-10-25	\N	t
661	119	2	06:00:00	22:00:00	2026-10-25	\N	t
662	119	3	06:00:00	22:00:00	2026-10-25	\N	t
663	119	4	06:00:00	22:00:00	2026-10-25	\N	t
664	119	5	06:00:00	22:00:00	2026-10-25	\N	t
665	120	1	09:00:00	18:00:00	2026-10-25	\N	t
666	120	2	09:00:00	18:00:00	2026-10-25	\N	t
667	120	3	09:00:00	18:00:00	2026-10-25	\N	t
668	120	4	09:00:00	18:00:00	2026-10-25	\N	t
669	120	5	09:00:00	18:00:00	2026-10-25	\N	t
670	120	6	09:00:00	18:00:00	2026-10-25	\N	t
671	121	1	09:00:00	18:00:00	2026-10-25	\N	t
672	121	2	09:00:00	18:00:00	2026-10-25	\N	t
673	121	3	09:00:00	18:00:00	2026-10-25	\N	t
674	121	4	09:00:00	18:00:00	2026-10-25	\N	t
675	121	5	09:00:00	18:00:00	2026-10-25	\N	t
676	121	6	09:00:00	18:00:00	2026-10-25	\N	t
677	122	1	06:00:00	22:00:00	2026-10-25	\N	t
678	122	2	06:00:00	22:00:00	2026-10-25	\N	t
679	122	3	06:00:00	22:00:00	2026-10-25	\N	t
680	122	4	06:00:00	22:00:00	2026-10-25	\N	t
681	122	5	06:00:00	22:00:00	2026-10-25	\N	t
682	123	1	09:00:00	18:00:00	2026-10-25	\N	t
683	123	2	09:00:00	18:00:00	2026-10-25	\N	t
684	123	3	09:00:00	18:00:00	2026-10-25	\N	t
685	123	4	09:00:00	18:00:00	2026-10-25	\N	t
686	123	5	09:00:00	18:00:00	2026-10-25	\N	t
687	123	6	09:00:00	18:00:00	2026-10-25	\N	t
688	124	1	06:00:00	22:00:00	2026-10-25	\N	t
689	124	2	06:00:00	22:00:00	2026-10-25	\N	t
690	124	3	06:00:00	22:00:00	2026-10-25	\N	t
691	124	4	06:00:00	22:00:00	2026-10-25	\N	t
692	124	5	06:00:00	22:00:00	2026-10-25	\N	t
693	125	1	09:00:00	18:00:00	2026-10-25	\N	t
694	125	2	09:00:00	18:00:00	2026-10-25	\N	t
695	125	3	09:00:00	18:00:00	2026-10-25	\N	t
696	125	4	09:00:00	18:00:00	2026-10-25	\N	t
697	125	5	09:00:00	18:00:00	2026-10-25	\N	t
698	125	6	09:00:00	18:00:00	2026-10-25	\N	t
699	126	1	06:00:00	22:00:00	2026-10-25	\N	t
700	126	2	06:00:00	22:00:00	2026-10-25	\N	t
701	126	3	06:00:00	22:00:00	2026-10-25	\N	t
702	126	4	06:00:00	22:00:00	2026-10-25	\N	t
703	126	5	06:00:00	22:00:00	2026-10-25	\N	t
704	127	1	09:00:00	18:00:00	2026-10-25	\N	t
705	127	2	09:00:00	18:00:00	2026-10-25	\N	t
706	127	3	09:00:00	18:00:00	2026-10-25	\N	t
707	127	4	09:00:00	18:00:00	2026-10-25	\N	t
708	127	5	09:00:00	18:00:00	2026-10-25	\N	t
709	127	6	09:00:00	18:00:00	2026-10-25	\N	t
710	128	1	06:00:00	22:00:00	2026-10-25	\N	t
711	128	2	06:00:00	22:00:00	2026-10-25	\N	t
712	128	3	06:00:00	22:00:00	2026-10-25	\N	t
713	128	4	06:00:00	22:00:00	2026-10-25	\N	t
714	128	5	06:00:00	22:00:00	2026-10-25	\N	t
715	129	1	09:00:00	18:00:00	2026-10-25	\N	t
716	129	2	09:00:00	18:00:00	2026-10-25	\N	t
717	129	3	09:00:00	18:00:00	2026-10-25	\N	t
718	129	4	09:00:00	18:00:00	2026-10-25	\N	t
719	129	5	09:00:00	18:00:00	2026-10-25	\N	t
720	129	6	09:00:00	18:00:00	2026-10-25	\N	t
721	130	1	09:00:00	18:00:00	2026-10-25	\N	t
722	130	2	09:00:00	18:00:00	2026-10-25	\N	t
723	130	3	09:00:00	18:00:00	2026-10-25	\N	t
724	130	4	09:00:00	18:00:00	2026-10-25	\N	t
725	130	5	09:00:00	18:00:00	2026-10-25	\N	t
726	130	6	09:00:00	18:00:00	2026-10-25	\N	t
727	131	1	06:00:00	22:00:00	2026-10-25	\N	t
728	131	2	06:00:00	22:00:00	2026-10-25	\N	t
729	131	3	06:00:00	22:00:00	2026-10-25	\N	t
730	131	4	06:00:00	22:00:00	2026-10-25	\N	t
731	131	5	06:00:00	22:00:00	2026-10-25	\N	t
732	132	1	09:00:00	18:00:00	2026-10-25	\N	t
733	132	2	09:00:00	18:00:00	2026-10-25	\N	t
734	132	3	09:00:00	18:00:00	2026-10-25	\N	t
735	132	4	09:00:00	18:00:00	2026-10-25	\N	t
736	132	5	09:00:00	18:00:00	2026-10-25	\N	t
737	132	6	09:00:00	18:00:00	2026-10-25	\N	t
738	133	1	09:00:00	18:00:00	2026-10-25	\N	t
739	133	2	09:00:00	18:00:00	2026-10-25	\N	t
740	133	3	09:00:00	18:00:00	2026-10-25	\N	t
741	133	4	09:00:00	18:00:00	2026-10-25	\N	t
742	133	5	09:00:00	18:00:00	2026-10-25	\N	t
743	133	6	09:00:00	18:00:00	2026-10-25	\N	t
744	134	1	06:00:00	22:00:00	2026-10-25	\N	t
745	134	2	06:00:00	22:00:00	2026-10-25	\N	t
746	134	3	06:00:00	22:00:00	2026-10-25	\N	t
747	134	4	06:00:00	22:00:00	2026-10-25	\N	t
748	134	5	06:00:00	22:00:00	2026-10-25	\N	t
749	135	1	09:00:00	18:00:00	2026-10-25	\N	t
750	135	2	09:00:00	18:00:00	2026-10-25	\N	t
751	135	3	09:00:00	18:00:00	2026-10-25	\N	t
752	135	4	09:00:00	18:00:00	2026-10-25	\N	t
753	135	5	09:00:00	18:00:00	2026-10-25	\N	t
754	135	6	09:00:00	18:00:00	2026-10-25	\N	t
755	136	1	06:00:00	22:00:00	2026-10-25	\N	t
756	136	2	06:00:00	22:00:00	2026-10-25	\N	t
757	136	3	06:00:00	22:00:00	2026-10-25	\N	t
758	136	4	06:00:00	22:00:00	2026-10-25	\N	t
759	136	5	06:00:00	22:00:00	2026-10-25	\N	t
760	137	1	09:00:00	18:00:00	2026-10-25	\N	t
761	137	2	09:00:00	18:00:00	2026-10-25	\N	t
762	137	3	09:00:00	18:00:00	2026-10-25	\N	t
763	137	4	09:00:00	18:00:00	2026-10-25	\N	t
764	137	5	09:00:00	18:00:00	2026-10-25	\N	t
765	137	6	09:00:00	18:00:00	2026-10-25	\N	t
766	138	1	06:00:00	22:00:00	2026-10-25	\N	t
767	138	2	06:00:00	22:00:00	2026-10-25	\N	t
768	138	3	06:00:00	22:00:00	2026-10-25	\N	t
769	138	4	06:00:00	22:00:00	2026-10-25	\N	t
770	138	5	06:00:00	22:00:00	2026-10-25	\N	t
771	139	1	09:00:00	18:00:00	2026-10-25	\N	t
772	139	2	09:00:00	18:00:00	2026-10-25	\N	t
773	139	3	09:00:00	18:00:00	2026-10-25	\N	t
774	139	4	09:00:00	18:00:00	2026-10-25	\N	t
775	139	5	09:00:00	18:00:00	2026-10-25	\N	t
776	139	6	09:00:00	18:00:00	2026-10-25	\N	t
777	140	1	06:00:00	22:00:00	2026-10-25	\N	t
778	140	2	06:00:00	22:00:00	2026-10-25	\N	t
779	140	3	06:00:00	22:00:00	2026-10-25	\N	t
780	140	4	06:00:00	22:00:00	2026-10-25	\N	t
781	140	5	06:00:00	22:00:00	2026-10-25	\N	t
782	141	1	09:00:00	18:00:00	2026-10-25	\N	t
783	141	2	09:00:00	18:00:00	2026-10-25	\N	t
784	141	3	09:00:00	18:00:00	2026-10-25	\N	t
785	141	4	09:00:00	18:00:00	2026-10-25	\N	t
786	141	5	09:00:00	18:00:00	2026-10-25	\N	t
787	141	6	09:00:00	18:00:00	2026-10-25	\N	t
788	142	1	09:00:00	18:00:00	2026-10-25	\N	t
789	142	2	09:00:00	18:00:00	2026-10-25	\N	t
790	142	3	09:00:00	18:00:00	2026-10-25	\N	t
791	142	4	09:00:00	18:00:00	2026-10-25	\N	t
792	142	5	09:00:00	18:00:00	2026-10-25	\N	t
793	142	6	09:00:00	18:00:00	2026-10-25	\N	t
794	143	1	06:00:00	22:00:00	2026-10-25	\N	t
795	143	2	06:00:00	22:00:00	2026-10-25	\N	t
796	143	3	06:00:00	22:00:00	2026-10-25	\N	t
797	143	4	06:00:00	22:00:00	2026-10-25	\N	t
798	143	5	06:00:00	22:00:00	2026-10-25	\N	t
799	144	1	09:00:00	18:00:00	2026-10-25	\N	t
800	144	2	09:00:00	18:00:00	2026-10-25	\N	t
801	144	3	09:00:00	18:00:00	2026-10-25	\N	t
802	144	4	09:00:00	18:00:00	2026-10-25	\N	t
803	144	5	09:00:00	18:00:00	2026-10-25	\N	t
804	144	6	09:00:00	18:00:00	2026-10-25	\N	t
805	145	1	09:00:00	18:00:00	2026-10-25	\N	t
806	145	2	09:00:00	18:00:00	2026-10-25	\N	t
807	145	3	09:00:00	18:00:00	2026-10-25	\N	t
808	145	4	09:00:00	18:00:00	2026-10-25	\N	t
809	145	5	09:00:00	18:00:00	2026-10-25	\N	t
810	145	6	09:00:00	18:00:00	2026-10-25	\N	t
811	146	1	06:00:00	22:00:00	2026-10-25	\N	t
812	146	2	06:00:00	22:00:00	2026-10-25	\N	t
813	146	3	06:00:00	22:00:00	2026-10-25	\N	t
814	146	4	06:00:00	22:00:00	2026-10-25	\N	t
815	146	5	06:00:00	22:00:00	2026-10-25	\N	t
816	147	1	09:00:00	18:00:00	2026-10-25	\N	t
817	147	2	09:00:00	18:00:00	2026-10-25	\N	t
818	147	3	09:00:00	18:00:00	2026-10-25	\N	t
819	147	4	09:00:00	18:00:00	2026-10-25	\N	t
820	147	5	09:00:00	18:00:00	2026-10-25	\N	t
821	147	6	09:00:00	18:00:00	2026-10-25	\N	t
822	148	1	06:00:00	22:00:00	2026-10-25	\N	t
823	148	2	06:00:00	22:00:00	2026-10-25	\N	t
824	148	3	06:00:00	22:00:00	2026-10-25	\N	t
825	148	4	06:00:00	22:00:00	2026-10-25	\N	t
826	148	5	06:00:00	22:00:00	2026-10-25	\N	t
827	149	1	09:00:00	18:00:00	2026-10-25	\N	t
828	149	2	09:00:00	18:00:00	2026-10-25	\N	t
829	149	3	09:00:00	18:00:00	2026-10-25	\N	t
830	149	4	09:00:00	18:00:00	2026-10-25	\N	t
831	149	5	09:00:00	18:00:00	2026-10-25	\N	t
832	149	6	09:00:00	18:00:00	2026-10-25	\N	t
833	150	1	06:00:00	22:00:00	2026-10-25	\N	t
834	150	2	06:00:00	22:00:00	2026-10-25	\N	t
835	150	3	06:00:00	22:00:00	2026-10-25	\N	t
836	150	4	06:00:00	22:00:00	2026-10-25	\N	t
837	150	5	06:00:00	22:00:00	2026-10-25	\N	t
838	151	1	09:00:00	18:00:00	2026-10-25	\N	t
839	151	2	09:00:00	18:00:00	2026-10-25	\N	t
840	151	3	09:00:00	18:00:00	2026-10-25	\N	t
841	151	4	09:00:00	18:00:00	2026-10-25	\N	t
842	151	5	09:00:00	18:00:00	2026-10-25	\N	t
843	151	6	09:00:00	18:00:00	2026-10-25	\N	t
844	152	1	06:00:00	22:00:00	2026-10-25	\N	t
845	152	2	06:00:00	22:00:00	2026-10-25	\N	t
846	152	3	06:00:00	22:00:00	2026-10-25	\N	t
847	152	4	06:00:00	22:00:00	2026-10-25	\N	t
848	152	5	06:00:00	22:00:00	2026-10-25	\N	t
849	153	1	09:00:00	18:00:00	2026-10-25	\N	t
850	153	2	09:00:00	18:00:00	2026-10-25	\N	t
851	153	3	09:00:00	18:00:00	2026-10-25	\N	t
852	153	4	09:00:00	18:00:00	2026-10-25	\N	t
853	153	5	09:00:00	18:00:00	2026-10-25	\N	t
854	153	6	09:00:00	18:00:00	2026-10-25	\N	t
855	154	1	09:00:00	18:00:00	2026-10-25	\N	t
856	154	2	09:00:00	18:00:00	2026-10-25	\N	t
857	154	3	09:00:00	18:00:00	2026-10-25	\N	t
858	154	4	09:00:00	18:00:00	2026-10-25	\N	t
859	154	5	09:00:00	18:00:00	2026-10-25	\N	t
860	154	6	09:00:00	18:00:00	2026-10-25	\N	t
861	155	1	06:00:00	22:00:00	2026-10-25	\N	t
862	155	2	06:00:00	22:00:00	2026-10-25	\N	t
863	155	3	06:00:00	22:00:00	2026-10-25	\N	t
864	155	4	06:00:00	22:00:00	2026-10-25	\N	t
865	155	5	06:00:00	22:00:00	2026-10-25	\N	t
866	156	1	09:00:00	18:00:00	2026-10-25	\N	t
867	156	2	09:00:00	18:00:00	2026-10-25	\N	t
868	156	3	09:00:00	18:00:00	2026-10-25	\N	t
869	156	4	09:00:00	18:00:00	2026-10-25	\N	t
870	156	5	09:00:00	18:00:00	2026-10-25	\N	t
871	156	6	09:00:00	18:00:00	2026-10-25	\N	t
872	157	1	09:00:00	18:00:00	2026-10-25	\N	t
873	157	2	09:00:00	18:00:00	2026-10-25	\N	t
874	157	3	09:00:00	18:00:00	2026-10-25	\N	t
875	157	4	09:00:00	18:00:00	2026-10-25	\N	t
876	157	5	09:00:00	18:00:00	2026-10-25	\N	t
877	157	6	09:00:00	18:00:00	2026-10-25	\N	t
878	158	1	06:00:00	22:00:00	2026-10-25	\N	t
879	158	2	06:00:00	22:00:00	2026-10-25	\N	t
880	158	3	06:00:00	22:00:00	2026-10-25	\N	t
881	158	4	06:00:00	22:00:00	2026-10-25	\N	t
882	158	5	06:00:00	22:00:00	2026-10-25	\N	t
883	159	1	09:00:00	18:00:00	2026-10-25	\N	t
884	159	2	09:00:00	18:00:00	2026-10-25	\N	t
885	159	3	09:00:00	18:00:00	2026-10-25	\N	t
886	159	4	09:00:00	18:00:00	2026-10-25	\N	t
887	159	5	09:00:00	18:00:00	2026-10-25	\N	t
888	159	6	09:00:00	18:00:00	2026-10-25	\N	t
889	160	1	06:00:00	22:00:00	2026-10-25	\N	t
890	160	2	06:00:00	22:00:00	2026-10-25	\N	t
891	160	3	06:00:00	22:00:00	2026-10-25	\N	t
892	160	4	06:00:00	22:00:00	2026-10-25	\N	t
893	160	5	06:00:00	22:00:00	2026-10-25	\N	t
894	161	1	09:00:00	18:00:00	2026-10-25	\N	t
895	161	2	09:00:00	18:00:00	2026-10-25	\N	t
896	161	3	09:00:00	18:00:00	2026-10-25	\N	t
897	161	4	09:00:00	18:00:00	2026-10-25	\N	t
898	161	5	09:00:00	18:00:00	2026-10-25	\N	t
899	161	6	09:00:00	18:00:00	2026-10-25	\N	t
900	162	1	06:00:00	22:00:00	2026-10-25	\N	t
901	162	2	06:00:00	22:00:00	2026-10-25	\N	t
902	162	3	06:00:00	22:00:00	2026-10-25	\N	t
903	162	4	06:00:00	22:00:00	2026-10-25	\N	t
904	162	5	06:00:00	22:00:00	2026-10-25	\N	t
905	163	1	09:00:00	18:00:00	2026-10-25	\N	t
906	163	2	09:00:00	18:00:00	2026-10-25	\N	t
907	163	3	09:00:00	18:00:00	2026-10-25	\N	t
908	163	4	09:00:00	18:00:00	2026-10-25	\N	t
909	163	5	09:00:00	18:00:00	2026-10-25	\N	t
910	163	6	09:00:00	18:00:00	2026-10-25	\N	t
911	164	1	06:00:00	22:00:00	2026-10-25	\N	t
912	164	2	06:00:00	22:00:00	2026-10-25	\N	t
913	164	3	06:00:00	22:00:00	2026-10-25	\N	t
914	164	4	06:00:00	22:00:00	2026-10-25	\N	t
915	164	5	06:00:00	22:00:00	2026-10-25	\N	t
916	165	1	09:00:00	18:00:00	2026-10-25	\N	t
917	165	2	09:00:00	18:00:00	2026-10-25	\N	t
918	165	3	09:00:00	18:00:00	2026-10-25	\N	t
919	165	4	09:00:00	18:00:00	2026-10-25	\N	t
920	165	5	09:00:00	18:00:00	2026-10-25	\N	t
921	165	6	09:00:00	18:00:00	2026-10-25	\N	t
922	166	1	09:00:00	18:00:00	2026-10-25	\N	t
923	166	2	09:00:00	18:00:00	2026-10-25	\N	t
924	166	3	09:00:00	18:00:00	2026-10-25	\N	t
925	166	4	09:00:00	18:00:00	2026-10-25	\N	t
926	166	5	09:00:00	18:00:00	2026-10-25	\N	t
927	166	6	09:00:00	18:00:00	2026-10-25	\N	t
928	167	1	06:00:00	22:00:00	2026-10-25	\N	t
929	167	2	06:00:00	22:00:00	2026-10-25	\N	t
930	167	3	06:00:00	22:00:00	2026-10-25	\N	t
931	167	4	06:00:00	22:00:00	2026-10-25	\N	t
932	167	5	06:00:00	22:00:00	2026-10-25	\N	t
933	168	1	09:00:00	18:00:00	2026-10-25	\N	t
934	168	2	09:00:00	18:00:00	2026-10-25	\N	t
935	168	3	09:00:00	18:00:00	2026-10-25	\N	t
936	168	4	09:00:00	18:00:00	2026-10-25	\N	t
937	168	5	09:00:00	18:00:00	2026-10-25	\N	t
938	168	6	09:00:00	18:00:00	2026-10-25	\N	t
939	169	1	09:00:00	18:00:00	2026-10-25	\N	t
940	169	2	09:00:00	18:00:00	2026-10-25	\N	t
941	169	3	09:00:00	18:00:00	2026-10-25	\N	t
942	169	4	09:00:00	18:00:00	2026-10-25	\N	t
943	169	5	09:00:00	18:00:00	2026-10-25	\N	t
944	169	6	09:00:00	18:00:00	2026-10-25	\N	t
945	170	1	06:00:00	22:00:00	2026-10-25	\N	t
946	170	2	06:00:00	22:00:00	2026-10-25	\N	t
947	170	3	06:00:00	22:00:00	2026-10-25	\N	t
948	170	4	06:00:00	22:00:00	2026-10-25	\N	t
949	170	5	06:00:00	22:00:00	2026-10-25	\N	t
950	171	1	09:00:00	18:00:00	2026-10-25	\N	t
951	171	2	09:00:00	18:00:00	2026-10-25	\N	t
952	171	3	09:00:00	18:00:00	2026-10-25	\N	t
953	171	4	09:00:00	18:00:00	2026-10-25	\N	t
954	171	5	09:00:00	18:00:00	2026-10-25	\N	t
955	171	6	09:00:00	18:00:00	2026-10-25	\N	t
956	172	1	06:00:00	22:00:00	2026-10-25	\N	t
957	172	2	06:00:00	22:00:00	2026-10-25	\N	t
958	172	3	06:00:00	22:00:00	2026-10-25	\N	t
959	172	4	06:00:00	22:00:00	2026-10-25	\N	t
960	172	5	06:00:00	22:00:00	2026-10-25	\N	t
961	173	1	09:00:00	18:00:00	2026-10-25	\N	t
962	173	2	09:00:00	18:00:00	2026-10-25	\N	t
963	173	3	09:00:00	18:00:00	2026-10-25	\N	t
964	173	4	09:00:00	18:00:00	2026-10-25	\N	t
965	173	5	09:00:00	18:00:00	2026-10-25	\N	t
966	173	6	09:00:00	18:00:00	2026-10-25	\N	t
967	174	1	06:00:00	22:00:00	2026-10-25	\N	t
968	174	2	06:00:00	22:00:00	2026-10-25	\N	t
969	174	3	06:00:00	22:00:00	2026-10-25	\N	t
970	174	4	06:00:00	22:00:00	2026-10-25	\N	t
971	174	5	06:00:00	22:00:00	2026-10-25	\N	t
972	175	1	09:00:00	18:00:00	2026-10-25	\N	t
973	175	2	09:00:00	18:00:00	2026-10-25	\N	t
974	175	3	09:00:00	18:00:00	2026-10-25	\N	t
975	175	4	09:00:00	18:00:00	2026-10-25	\N	t
976	175	5	09:00:00	18:00:00	2026-10-25	\N	t
977	175	6	09:00:00	18:00:00	2026-10-25	\N	t
978	176	1	06:00:00	22:00:00	2026-10-25	\N	t
979	176	2	06:00:00	22:00:00	2026-10-25	\N	t
980	176	3	06:00:00	22:00:00	2026-10-25	\N	t
981	176	4	06:00:00	22:00:00	2026-10-25	\N	t
982	176	5	06:00:00	22:00:00	2026-10-25	\N	t
983	177	1	09:00:00	18:00:00	2026-10-25	\N	t
984	177	2	09:00:00	18:00:00	2026-10-25	\N	t
985	177	3	09:00:00	18:00:00	2026-10-25	\N	t
986	177	4	09:00:00	18:00:00	2026-10-25	\N	t
987	177	5	09:00:00	18:00:00	2026-10-25	\N	t
988	177	6	09:00:00	18:00:00	2026-10-25	\N	t
989	178	1	09:00:00	18:00:00	2026-10-25	\N	t
990	178	2	09:00:00	18:00:00	2026-10-25	\N	t
991	178	3	09:00:00	18:00:00	2026-10-25	\N	t
992	178	4	09:00:00	18:00:00	2026-10-25	\N	t
993	178	5	09:00:00	18:00:00	2026-10-25	\N	t
994	178	6	09:00:00	18:00:00	2026-10-25	\N	t
995	179	1	06:00:00	22:00:00	2026-10-25	\N	t
996	179	2	06:00:00	22:00:00	2026-10-25	\N	t
997	179	3	06:00:00	22:00:00	2026-10-25	\N	t
998	179	4	06:00:00	22:00:00	2026-10-25	\N	t
999	179	5	06:00:00	22:00:00	2026-10-25	\N	t
1000	180	1	09:00:00	18:00:00	2026-10-25	\N	t
1001	180	2	09:00:00	18:00:00	2026-10-25	\N	t
1002	180	3	09:00:00	18:00:00	2026-10-25	\N	t
1003	180	4	09:00:00	18:00:00	2026-10-25	\N	t
1004	180	5	09:00:00	18:00:00	2026-10-25	\N	t
1005	180	6	09:00:00	18:00:00	2026-10-25	\N	t
1006	181	1	09:00:00	18:00:00	2026-10-25	\N	t
1007	181	2	09:00:00	18:00:00	2026-10-25	\N	t
1008	181	3	09:00:00	18:00:00	2026-10-25	\N	t
1009	181	4	09:00:00	18:00:00	2026-10-25	\N	t
1010	181	5	09:00:00	18:00:00	2026-10-25	\N	t
1011	181	6	09:00:00	18:00:00	2026-10-25	\N	t
1012	182	1	06:00:00	22:00:00	2026-10-25	\N	t
1013	182	2	06:00:00	22:00:00	2026-10-25	\N	t
1014	182	3	06:00:00	22:00:00	2026-10-25	\N	t
1015	182	4	06:00:00	22:00:00	2026-10-25	\N	t
1016	182	5	06:00:00	22:00:00	2026-10-25	\N	t
1017	183	1	09:00:00	18:00:00	2026-10-25	\N	t
1018	183	2	09:00:00	18:00:00	2026-10-25	\N	t
1019	183	3	09:00:00	18:00:00	2026-10-25	\N	t
1020	183	4	09:00:00	18:00:00	2026-10-25	\N	t
1021	183	5	09:00:00	18:00:00	2026-10-25	\N	t
1022	183	6	09:00:00	18:00:00	2026-10-25	\N	t
1023	184	1	06:00:00	22:00:00	2026-10-25	\N	t
1024	184	2	06:00:00	22:00:00	2026-10-25	\N	t
1025	184	3	06:00:00	22:00:00	2026-10-25	\N	t
1026	184	4	06:00:00	22:00:00	2026-10-25	\N	t
1027	184	5	06:00:00	22:00:00	2026-10-25	\N	t
1028	185	1	09:00:00	18:00:00	2026-10-25	\N	t
1029	185	2	09:00:00	18:00:00	2026-10-25	\N	t
1030	185	3	09:00:00	18:00:00	2026-10-25	\N	t
1031	185	4	09:00:00	18:00:00	2026-10-25	\N	t
1032	185	5	09:00:00	18:00:00	2026-10-25	\N	t
1033	185	6	09:00:00	18:00:00	2026-10-25	\N	t
1034	186	1	06:00:00	22:00:00	2026-10-25	\N	t
1035	186	2	06:00:00	22:00:00	2026-10-25	\N	t
1036	186	3	06:00:00	22:00:00	2026-10-25	\N	t
1037	186	4	06:00:00	22:00:00	2026-10-25	\N	t
1038	186	5	06:00:00	22:00:00	2026-10-25	\N	t
1039	187	1	09:00:00	18:00:00	2026-10-25	\N	t
1040	187	2	09:00:00	18:00:00	2026-10-25	\N	t
1041	187	3	09:00:00	18:00:00	2026-10-25	\N	t
1042	187	4	09:00:00	18:00:00	2026-10-25	\N	t
1043	187	5	09:00:00	18:00:00	2026-10-25	\N	t
1044	187	6	09:00:00	18:00:00	2026-10-25	\N	t
1045	188	1	06:00:00	22:00:00	2026-10-25	\N	t
1046	188	2	06:00:00	22:00:00	2026-10-25	\N	t
1047	188	3	06:00:00	22:00:00	2026-10-25	\N	t
1048	188	4	06:00:00	22:00:00	2026-10-25	\N	t
1049	188	5	06:00:00	22:00:00	2026-10-25	\N	t
1050	189	1	09:00:00	18:00:00	2026-10-25	\N	t
1051	189	2	09:00:00	18:00:00	2026-10-25	\N	t
1052	189	3	09:00:00	18:00:00	2026-10-25	\N	t
1053	189	4	09:00:00	18:00:00	2026-10-25	\N	t
1054	189	5	09:00:00	18:00:00	2026-10-25	\N	t
1055	189	6	09:00:00	18:00:00	2026-10-25	\N	t
1056	190	1	09:00:00	18:00:00	2026-10-25	\N	t
1057	190	2	09:00:00	18:00:00	2026-10-25	\N	t
1058	190	3	09:00:00	18:00:00	2026-10-25	\N	t
1059	190	4	09:00:00	18:00:00	2026-10-25	\N	t
1060	190	5	09:00:00	18:00:00	2026-10-25	\N	t
1061	190	6	09:00:00	18:00:00	2026-10-25	\N	t
1062	191	1	06:00:00	22:00:00	2026-10-25	\N	t
1063	191	2	06:00:00	22:00:00	2026-10-25	\N	t
1064	191	3	06:00:00	22:00:00	2026-10-25	\N	t
1065	191	4	06:00:00	22:00:00	2026-10-25	\N	t
1066	191	5	06:00:00	22:00:00	2026-10-25	\N	t
1067	192	1	09:00:00	18:00:00	2026-10-25	\N	t
1068	192	2	09:00:00	18:00:00	2026-10-25	\N	t
1069	192	3	09:00:00	18:00:00	2026-10-25	\N	t
1070	192	4	09:00:00	18:00:00	2026-10-25	\N	t
1071	192	5	09:00:00	18:00:00	2026-10-25	\N	t
1072	192	6	09:00:00	18:00:00	2026-10-25	\N	t
1073	193	1	09:00:00	18:00:00	2026-10-25	\N	t
1074	193	2	09:00:00	18:00:00	2026-10-25	\N	t
1075	193	3	09:00:00	18:00:00	2026-10-25	\N	t
1076	193	4	09:00:00	18:00:00	2026-10-25	\N	t
1077	193	5	09:00:00	18:00:00	2026-10-25	\N	t
1078	193	6	09:00:00	18:00:00	2026-10-25	\N	t
1079	194	1	06:00:00	22:00:00	2026-10-25	\N	t
1080	194	2	06:00:00	22:00:00	2026-10-25	\N	t
1081	194	3	06:00:00	22:00:00	2026-10-25	\N	t
1082	194	4	06:00:00	22:00:00	2026-10-25	\N	t
1083	194	5	06:00:00	22:00:00	2026-10-25	\N	t
1084	195	1	09:00:00	18:00:00	2026-10-25	\N	t
1085	195	2	09:00:00	18:00:00	2026-10-25	\N	t
1086	195	3	09:00:00	18:00:00	2026-10-25	\N	t
1087	195	4	09:00:00	18:00:00	2026-10-25	\N	t
1088	195	5	09:00:00	18:00:00	2026-10-25	\N	t
1089	195	6	09:00:00	18:00:00	2026-10-25	\N	t
1090	196	1	06:00:00	22:00:00	2026-10-25	\N	t
1091	196	2	06:00:00	22:00:00	2026-10-25	\N	t
1092	196	3	06:00:00	22:00:00	2026-10-25	\N	t
1093	196	4	06:00:00	22:00:00	2026-10-25	\N	t
1094	196	5	06:00:00	22:00:00	2026-10-25	\N	t
1095	197	1	09:00:00	18:00:00	2026-10-25	\N	t
1096	197	2	09:00:00	18:00:00	2026-10-25	\N	t
1097	197	3	09:00:00	18:00:00	2026-10-25	\N	t
1098	197	4	09:00:00	18:00:00	2026-10-25	\N	t
1099	197	5	09:00:00	18:00:00	2026-10-25	\N	t
1100	197	6	09:00:00	18:00:00	2026-10-25	\N	t
1101	198	1	06:00:00	22:00:00	2026-10-25	\N	t
1102	198	2	06:00:00	22:00:00	2026-10-25	\N	t
1103	198	3	06:00:00	22:00:00	2026-10-25	\N	t
1104	198	4	06:00:00	22:00:00	2026-10-25	\N	t
1105	198	5	06:00:00	22:00:00	2026-10-25	\N	t
1106	199	1	09:00:00	18:00:00	2026-10-25	\N	t
1107	199	2	09:00:00	18:00:00	2026-10-25	\N	t
1108	199	3	09:00:00	18:00:00	2026-10-25	\N	t
1109	199	4	09:00:00	18:00:00	2026-10-25	\N	t
1110	199	5	09:00:00	18:00:00	2026-10-25	\N	t
1111	199	6	09:00:00	18:00:00	2026-10-25	\N	t
1112	200	1	06:00:00	22:00:00	2026-10-25	\N	t
1113	200	2	06:00:00	22:00:00	2026-10-25	\N	t
1114	200	3	06:00:00	22:00:00	2026-10-25	\N	t
1115	200	4	06:00:00	22:00:00	2026-10-25	\N	t
1116	200	5	06:00:00	22:00:00	2026-10-25	\N	t
1117	201	1	09:00:00	18:00:00	2026-10-25	\N	t
1118	201	2	09:00:00	18:00:00	2026-10-25	\N	t
1119	201	3	09:00:00	18:00:00	2026-10-25	\N	t
1120	201	4	09:00:00	18:00:00	2026-10-25	\N	t
1121	201	5	09:00:00	18:00:00	2026-10-25	\N	t
1122	201	6	09:00:00	18:00:00	2026-10-25	\N	t
1123	202	1	09:00:00	18:00:00	2026-10-25	\N	t
1124	202	2	09:00:00	18:00:00	2026-10-25	\N	t
1125	202	3	09:00:00	18:00:00	2026-10-25	\N	t
1126	202	4	09:00:00	18:00:00	2026-10-25	\N	t
1127	202	5	09:00:00	18:00:00	2026-10-25	\N	t
1128	202	6	09:00:00	18:00:00	2026-10-25	\N	t
1129	203	1	06:00:00	22:00:00	2026-10-25	\N	t
1130	203	2	06:00:00	22:00:00	2026-10-25	\N	t
1131	203	3	06:00:00	22:00:00	2026-10-25	\N	t
1132	203	4	06:00:00	22:00:00	2026-10-25	\N	t
1133	203	5	06:00:00	22:00:00	2026-10-25	\N	t
1134	204	1	09:00:00	18:00:00	2026-10-25	\N	t
1135	204	2	09:00:00	18:00:00	2026-10-25	\N	t
1136	204	3	09:00:00	18:00:00	2026-10-25	\N	t
1137	204	4	09:00:00	18:00:00	2026-10-25	\N	t
1138	204	5	09:00:00	18:00:00	2026-10-25	\N	t
1139	204	6	09:00:00	18:00:00	2026-10-25	\N	t
1140	205	1	09:00:00	18:00:00	2026-10-25	\N	t
1141	205	2	09:00:00	18:00:00	2026-10-25	\N	t
1142	205	3	09:00:00	18:00:00	2026-10-25	\N	t
1143	205	4	09:00:00	18:00:00	2026-10-25	\N	t
1144	205	5	09:00:00	18:00:00	2026-10-25	\N	t
1145	205	6	09:00:00	18:00:00	2026-10-25	\N	t
1146	206	1	06:00:00	22:00:00	2026-10-25	\N	t
1147	206	2	06:00:00	22:00:00	2026-10-25	\N	t
1148	206	3	06:00:00	22:00:00	2026-10-25	\N	t
1149	206	4	06:00:00	22:00:00	2026-10-25	\N	t
1150	206	5	06:00:00	22:00:00	2026-10-25	\N	t
1151	207	1	09:00:00	18:00:00	2026-10-25	\N	t
1152	207	2	09:00:00	18:00:00	2026-10-25	\N	t
1153	207	3	09:00:00	18:00:00	2026-10-25	\N	t
1154	207	4	09:00:00	18:00:00	2026-10-25	\N	t
1155	207	5	09:00:00	18:00:00	2026-10-25	\N	t
1156	207	6	09:00:00	18:00:00	2026-10-25	\N	t
1157	208	1	06:00:00	22:00:00	2026-10-25	\N	t
1158	208	2	06:00:00	22:00:00	2026-10-25	\N	t
1159	208	3	06:00:00	22:00:00	2026-10-25	\N	t
1160	208	4	06:00:00	22:00:00	2026-10-25	\N	t
1161	208	5	06:00:00	22:00:00	2026-10-25	\N	t
1162	209	1	09:00:00	18:00:00	2026-10-25	\N	t
1163	209	2	09:00:00	18:00:00	2026-10-25	\N	t
1164	209	3	09:00:00	18:00:00	2026-10-25	\N	t
1165	209	4	09:00:00	18:00:00	2026-10-25	\N	t
1166	209	5	09:00:00	18:00:00	2026-10-25	\N	t
1167	209	6	09:00:00	18:00:00	2026-10-25	\N	t
1168	210	1	06:00:00	22:00:00	2026-10-25	\N	t
1169	210	2	06:00:00	22:00:00	2026-10-25	\N	t
1170	210	3	06:00:00	22:00:00	2026-10-25	\N	t
1171	210	4	06:00:00	22:00:00	2026-10-25	\N	t
1172	210	5	06:00:00	22:00:00	2026-10-25	\N	t
1173	211	1	09:00:00	18:00:00	2026-10-25	\N	t
1174	211	2	09:00:00	18:00:00	2026-10-25	\N	t
1175	211	3	09:00:00	18:00:00	2026-10-25	\N	t
1176	211	4	09:00:00	18:00:00	2026-10-25	\N	t
1177	211	5	09:00:00	18:00:00	2026-10-25	\N	t
1178	211	6	09:00:00	18:00:00	2026-10-25	\N	t
1179	212	1	06:00:00	22:00:00	2026-10-25	\N	t
1180	212	2	06:00:00	22:00:00	2026-10-25	\N	t
1181	212	3	06:00:00	22:00:00	2026-10-25	\N	t
1182	212	4	06:00:00	22:00:00	2026-10-25	\N	t
1183	212	5	06:00:00	22:00:00	2026-10-25	\N	t
1184	213	1	09:00:00	18:00:00	2026-10-25	\N	t
1185	213	2	09:00:00	18:00:00	2026-10-25	\N	t
1186	213	3	09:00:00	18:00:00	2026-10-25	\N	t
1187	213	4	09:00:00	18:00:00	2026-10-25	\N	t
1188	213	5	09:00:00	18:00:00	2026-10-25	\N	t
1189	213	6	09:00:00	18:00:00	2026-10-25	\N	t
1190	214	1	09:00:00	18:00:00	2026-10-25	\N	t
1191	214	2	09:00:00	18:00:00	2026-10-25	\N	t
1192	214	3	09:00:00	18:00:00	2026-10-25	\N	t
1193	214	4	09:00:00	18:00:00	2026-10-25	\N	t
1194	214	5	09:00:00	18:00:00	2026-10-25	\N	t
1195	214	6	09:00:00	18:00:00	2026-10-25	\N	t
1196	215	1	06:00:00	22:00:00	2026-10-25	\N	t
1197	215	2	06:00:00	22:00:00	2026-10-25	\N	t
1198	215	3	06:00:00	22:00:00	2026-10-25	\N	t
1199	215	4	06:00:00	22:00:00	2026-10-25	\N	t
1200	215	5	06:00:00	22:00:00	2026-10-25	\N	t
1201	216	1	09:00:00	18:00:00	2026-10-25	\N	t
1202	216	2	09:00:00	18:00:00	2026-10-25	\N	t
1203	216	3	09:00:00	18:00:00	2026-10-25	\N	t
1204	216	4	09:00:00	18:00:00	2026-10-25	\N	t
1205	216	5	09:00:00	18:00:00	2026-10-25	\N	t
1206	216	6	09:00:00	18:00:00	2026-10-25	\N	t
1207	217	1	09:00:00	18:00:00	2026-10-25	\N	t
1208	217	2	09:00:00	18:00:00	2026-10-25	\N	t
1209	217	3	09:00:00	18:00:00	2026-10-25	\N	t
1210	217	4	09:00:00	18:00:00	2026-10-25	\N	t
1211	217	5	09:00:00	18:00:00	2026-10-25	\N	t
1212	217	6	09:00:00	18:00:00	2026-10-25	\N	t
1213	218	1	06:00:00	22:00:00	2026-10-25	\N	t
1214	218	2	06:00:00	22:00:00	2026-10-25	\N	t
1215	218	3	06:00:00	22:00:00	2026-10-25	\N	t
1216	218	4	06:00:00	22:00:00	2026-10-25	\N	t
1217	218	5	06:00:00	22:00:00	2026-10-25	\N	t
1218	219	1	09:00:00	18:00:00	2026-10-25	\N	t
1219	219	2	09:00:00	18:00:00	2026-10-25	\N	t
1220	219	3	09:00:00	18:00:00	2026-10-25	\N	t
1221	219	4	09:00:00	18:00:00	2026-10-25	\N	t
1222	219	5	09:00:00	18:00:00	2026-10-25	\N	t
1223	219	6	09:00:00	18:00:00	2026-10-25	\N	t
1224	220	1	06:00:00	22:00:00	2026-10-25	\N	t
1225	220	2	06:00:00	22:00:00	2026-10-25	\N	t
1226	220	3	06:00:00	22:00:00	2026-10-25	\N	t
1227	220	4	06:00:00	22:00:00	2026-10-25	\N	t
1228	220	5	06:00:00	22:00:00	2026-10-25	\N	t
1229	221	1	09:00:00	18:00:00	2026-10-25	\N	t
1230	221	2	09:00:00	18:00:00	2026-10-25	\N	t
1231	221	3	09:00:00	18:00:00	2026-10-25	\N	t
1232	221	4	09:00:00	18:00:00	2026-10-25	\N	t
1233	221	5	09:00:00	18:00:00	2026-10-25	\N	t
1234	221	6	09:00:00	18:00:00	2026-10-25	\N	t
1235	222	1	06:00:00	22:00:00	2026-10-25	\N	t
1236	222	2	06:00:00	22:00:00	2026-10-25	\N	t
1237	222	3	06:00:00	22:00:00	2026-10-25	\N	t
1238	222	4	06:00:00	22:00:00	2026-10-25	\N	t
1239	222	5	06:00:00	22:00:00	2026-10-25	\N	t
1240	223	1	09:00:00	18:00:00	2026-10-25	\N	t
1241	223	2	09:00:00	18:00:00	2026-10-25	\N	t
1242	223	3	09:00:00	18:00:00	2026-10-25	\N	t
1243	223	4	09:00:00	18:00:00	2026-10-25	\N	t
1244	223	5	09:00:00	18:00:00	2026-10-25	\N	t
1245	223	6	09:00:00	18:00:00	2026-10-25	\N	t
1246	224	1	06:00:00	22:00:00	2026-10-25	\N	t
1247	224	2	06:00:00	22:00:00	2026-10-25	\N	t
1248	224	3	06:00:00	22:00:00	2026-10-25	\N	t
1249	224	4	06:00:00	22:00:00	2026-10-25	\N	t
1250	224	5	06:00:00	22:00:00	2026-10-25	\N	t
1251	225	1	09:00:00	18:00:00	2026-10-25	\N	t
1252	225	2	09:00:00	18:00:00	2026-10-25	\N	t
1253	225	3	09:00:00	18:00:00	2026-10-25	\N	t
1254	225	4	09:00:00	18:00:00	2026-10-25	\N	t
1255	225	5	09:00:00	18:00:00	2026-10-25	\N	t
1256	225	6	09:00:00	18:00:00	2026-10-25	\N	t
1257	226	1	09:00:00	18:00:00	2026-10-25	\N	t
1258	226	2	09:00:00	18:00:00	2026-10-25	\N	t
1259	226	3	09:00:00	18:00:00	2026-10-25	\N	t
1260	226	4	09:00:00	18:00:00	2026-10-25	\N	t
1261	226	5	09:00:00	18:00:00	2026-10-25	\N	t
1262	226	6	09:00:00	18:00:00	2026-10-25	\N	t
1263	227	1	06:00:00	22:00:00	2026-10-25	\N	t
1264	227	2	06:00:00	22:00:00	2026-10-25	\N	t
1265	227	3	06:00:00	22:00:00	2026-10-25	\N	t
1266	227	4	06:00:00	22:00:00	2026-10-25	\N	t
1267	227	5	06:00:00	22:00:00	2026-10-25	\N	t
1268	228	1	09:00:00	18:00:00	2026-10-25	\N	t
1269	228	2	09:00:00	18:00:00	2026-10-25	\N	t
1270	228	3	09:00:00	18:00:00	2026-10-25	\N	t
1271	228	4	09:00:00	18:00:00	2026-10-25	\N	t
1272	228	5	09:00:00	18:00:00	2026-10-25	\N	t
1273	228	6	09:00:00	18:00:00	2026-10-25	\N	t
1274	229	1	09:00:00	18:00:00	2026-10-25	\N	t
1275	229	2	09:00:00	18:00:00	2026-10-25	\N	t
1276	229	3	09:00:00	18:00:00	2026-10-25	\N	t
1277	229	4	09:00:00	18:00:00	2026-10-25	\N	t
1278	229	5	09:00:00	18:00:00	2026-10-25	\N	t
1279	229	6	09:00:00	18:00:00	2026-10-25	\N	t
1280	230	1	06:00:00	22:00:00	2026-10-25	\N	t
1281	230	2	06:00:00	22:00:00	2026-10-25	\N	t
1282	230	3	06:00:00	22:00:00	2026-10-25	\N	t
1283	230	4	06:00:00	22:00:00	2026-10-25	\N	t
1284	230	5	06:00:00	22:00:00	2026-10-25	\N	t
1285	231	1	09:00:00	18:00:00	2026-10-25	\N	t
1286	231	2	09:00:00	18:00:00	2026-10-25	\N	t
1287	231	3	09:00:00	18:00:00	2026-10-25	\N	t
1288	231	4	09:00:00	18:00:00	2026-10-25	\N	t
1289	231	5	09:00:00	18:00:00	2026-10-25	\N	t
1290	231	6	09:00:00	18:00:00	2026-10-25	\N	t
1291	232	1	06:00:00	22:00:00	2026-10-25	\N	t
1292	232	2	06:00:00	22:00:00	2026-10-25	\N	t
1293	232	3	06:00:00	22:00:00	2026-10-25	\N	t
1294	232	4	06:00:00	22:00:00	2026-10-25	\N	t
1295	232	5	06:00:00	22:00:00	2026-10-25	\N	t
1296	233	1	09:00:00	18:00:00	2026-10-25	\N	t
1297	233	2	09:00:00	18:00:00	2026-10-25	\N	t
1298	233	3	09:00:00	18:00:00	2026-10-25	\N	t
1299	233	4	09:00:00	18:00:00	2026-10-25	\N	t
1300	233	5	09:00:00	18:00:00	2026-10-25	\N	t
1301	233	6	09:00:00	18:00:00	2026-10-25	\N	t
1302	234	1	06:00:00	22:00:00	2026-10-25	\N	t
1303	234	2	06:00:00	22:00:00	2026-10-25	\N	t
1304	234	3	06:00:00	22:00:00	2026-10-25	\N	t
1305	234	4	06:00:00	22:00:00	2026-10-25	\N	t
1306	234	5	06:00:00	22:00:00	2026-10-25	\N	t
1307	235	1	09:00:00	18:00:00	2026-10-25	\N	t
1308	235	2	09:00:00	18:00:00	2026-10-25	\N	t
1309	235	3	09:00:00	18:00:00	2026-10-25	\N	t
1310	235	4	09:00:00	18:00:00	2026-10-25	\N	t
1311	235	5	09:00:00	18:00:00	2026-10-25	\N	t
1312	235	6	09:00:00	18:00:00	2026-10-25	\N	t
1313	236	1	06:00:00	22:00:00	2026-10-25	\N	t
1314	236	2	06:00:00	22:00:00	2026-10-25	\N	t
1315	236	3	06:00:00	22:00:00	2026-10-25	\N	t
1316	236	4	06:00:00	22:00:00	2026-10-25	\N	t
1317	236	5	06:00:00	22:00:00	2026-10-25	\N	t
1318	237	1	09:00:00	18:00:00	2026-10-25	\N	t
1319	237	2	09:00:00	18:00:00	2026-10-25	\N	t
1320	237	3	09:00:00	18:00:00	2026-10-25	\N	t
1321	237	4	09:00:00	18:00:00	2026-10-25	\N	t
1322	237	5	09:00:00	18:00:00	2026-10-25	\N	t
1323	237	6	09:00:00	18:00:00	2026-10-25	\N	t
1324	238	1	09:00:00	18:00:00	2026-10-25	\N	t
1325	238	2	09:00:00	18:00:00	2026-10-25	\N	t
1326	238	3	09:00:00	18:00:00	2026-10-25	\N	t
1327	238	4	09:00:00	18:00:00	2026-10-25	\N	t
1328	238	5	09:00:00	18:00:00	2026-10-25	\N	t
1329	238	6	09:00:00	18:00:00	2026-10-25	\N	t
1330	239	1	06:00:00	22:00:00	2026-10-25	\N	t
1331	239	2	06:00:00	22:00:00	2026-10-25	\N	t
1332	239	3	06:00:00	22:00:00	2026-10-25	\N	t
1333	239	4	06:00:00	22:00:00	2026-10-25	\N	t
1334	239	5	06:00:00	22:00:00	2026-10-25	\N	t
1335	240	1	09:00:00	18:00:00	2026-10-25	\N	t
1336	240	2	09:00:00	18:00:00	2026-10-25	\N	t
1337	240	3	09:00:00	18:00:00	2026-10-25	\N	t
1338	240	4	09:00:00	18:00:00	2026-10-25	\N	t
1339	240	5	09:00:00	18:00:00	2026-10-25	\N	t
1340	240	6	09:00:00	18:00:00	2026-10-25	\N	t
1341	241	1	09:00:00	18:00:00	2026-10-25	\N	t
1342	241	2	09:00:00	18:00:00	2026-10-25	\N	t
1343	241	3	09:00:00	18:00:00	2026-10-25	\N	t
1344	241	4	09:00:00	18:00:00	2026-10-25	\N	t
1345	241	5	09:00:00	18:00:00	2026-10-25	\N	t
1346	241	6	09:00:00	18:00:00	2026-10-25	\N	t
1347	242	1	06:00:00	22:00:00	2026-10-25	\N	t
1348	242	2	06:00:00	22:00:00	2026-10-25	\N	t
1349	242	3	06:00:00	22:00:00	2026-10-25	\N	t
1350	242	4	06:00:00	22:00:00	2026-10-25	\N	t
1351	242	5	06:00:00	22:00:00	2026-10-25	\N	t
1352	243	1	09:00:00	18:00:00	2026-10-25	\N	t
1353	243	2	09:00:00	18:00:00	2026-10-25	\N	t
1354	243	3	09:00:00	18:00:00	2026-10-25	\N	t
1355	243	4	09:00:00	18:00:00	2026-10-25	\N	t
1356	243	5	09:00:00	18:00:00	2026-10-25	\N	t
1357	243	6	09:00:00	18:00:00	2026-10-25	\N	t
1358	244	1	06:00:00	22:00:00	2026-10-25	\N	t
1359	244	2	06:00:00	22:00:00	2026-10-25	\N	t
1360	244	3	06:00:00	22:00:00	2026-10-25	\N	t
1361	244	4	06:00:00	22:00:00	2026-10-25	\N	t
1362	244	5	06:00:00	22:00:00	2026-10-25	\N	t
1363	245	1	09:00:00	18:00:00	2026-10-25	\N	t
1364	245	2	09:00:00	18:00:00	2026-10-25	\N	t
1365	245	3	09:00:00	18:00:00	2026-10-25	\N	t
1366	245	4	09:00:00	18:00:00	2026-10-25	\N	t
1367	245	5	09:00:00	18:00:00	2026-10-25	\N	t
1368	245	6	09:00:00	18:00:00	2026-10-25	\N	t
1369	246	1	06:00:00	22:00:00	2026-10-25	\N	t
1370	246	2	06:00:00	22:00:00	2026-10-25	\N	t
1371	246	3	06:00:00	22:00:00	2026-10-25	\N	t
1372	246	4	06:00:00	22:00:00	2026-10-25	\N	t
1373	246	5	06:00:00	22:00:00	2026-10-25	\N	t
1374	247	1	09:00:00	18:00:00	2026-10-25	\N	t
1375	247	2	09:00:00	18:00:00	2026-10-25	\N	t
1376	247	3	09:00:00	18:00:00	2026-10-25	\N	t
1377	247	4	09:00:00	18:00:00	2026-10-25	\N	t
1378	247	5	09:00:00	18:00:00	2026-10-25	\N	t
1379	247	6	09:00:00	18:00:00	2026-10-25	\N	t
1380	248	1	06:00:00	22:00:00	2026-10-25	\N	t
1381	248	2	06:00:00	22:00:00	2026-10-25	\N	t
1382	248	3	06:00:00	22:00:00	2026-10-25	\N	t
1383	248	4	06:00:00	22:00:00	2026-10-25	\N	t
1384	248	5	06:00:00	22:00:00	2026-10-25	\N	t
1385	249	1	09:00:00	18:00:00	2026-10-25	\N	t
1386	249	2	09:00:00	18:00:00	2026-10-25	\N	t
1387	249	3	09:00:00	18:00:00	2026-10-25	\N	t
1388	249	4	09:00:00	18:00:00	2026-10-25	\N	t
1389	249	5	09:00:00	18:00:00	2026-10-25	\N	t
1390	249	6	09:00:00	18:00:00	2026-10-25	\N	t
1391	250	1	09:00:00	18:00:00	2026-10-25	\N	t
1392	250	2	09:00:00	18:00:00	2026-10-25	\N	t
1393	250	3	09:00:00	18:00:00	2026-10-25	\N	t
1394	250	4	09:00:00	18:00:00	2026-10-25	\N	t
1395	250	5	09:00:00	18:00:00	2026-10-25	\N	t
1396	250	6	09:00:00	18:00:00	2026-10-25	\N	t
1397	251	1	06:00:00	22:00:00	2026-10-25	\N	t
1398	251	2	06:00:00	22:00:00	2026-10-25	\N	t
1399	251	3	06:00:00	22:00:00	2026-10-25	\N	t
1400	251	4	06:00:00	22:00:00	2026-10-25	\N	t
1401	251	5	06:00:00	22:00:00	2026-10-25	\N	t
1402	252	1	09:00:00	18:00:00	2026-10-25	\N	t
1403	252	2	09:00:00	18:00:00	2026-10-25	\N	t
1404	252	3	09:00:00	18:00:00	2026-10-25	\N	t
1405	252	4	09:00:00	18:00:00	2026-10-25	\N	t
1406	252	5	09:00:00	18:00:00	2026-10-25	\N	t
1407	252	6	09:00:00	18:00:00	2026-10-25	\N	t
1408	253	1	09:00:00	18:00:00	2026-10-25	\N	t
1409	253	2	09:00:00	18:00:00	2026-10-25	\N	t
1410	253	3	09:00:00	18:00:00	2026-10-25	\N	t
1411	253	4	09:00:00	18:00:00	2026-10-25	\N	t
1412	253	5	09:00:00	18:00:00	2026-10-25	\N	t
1413	253	6	09:00:00	18:00:00	2026-10-25	\N	t
1414	254	1	06:00:00	22:00:00	2026-10-25	\N	t
1415	254	2	06:00:00	22:00:00	2026-10-25	\N	t
1416	254	3	06:00:00	22:00:00	2026-10-25	\N	t
1417	254	4	06:00:00	22:00:00	2026-10-25	\N	t
1418	254	5	06:00:00	22:00:00	2026-10-25	\N	t
1419	255	1	09:00:00	18:00:00	2026-10-25	\N	t
1420	255	2	09:00:00	18:00:00	2026-10-25	\N	t
1421	255	3	09:00:00	18:00:00	2026-10-25	\N	t
1422	255	4	09:00:00	18:00:00	2026-10-25	\N	t
1423	255	5	09:00:00	18:00:00	2026-10-25	\N	t
1424	255	6	09:00:00	18:00:00	2026-10-25	\N	t
1425	256	1	06:00:00	22:00:00	2026-10-25	\N	t
1426	256	2	06:00:00	22:00:00	2026-10-25	\N	t
1427	256	3	06:00:00	22:00:00	2026-10-25	\N	t
1428	256	4	06:00:00	22:00:00	2026-10-25	\N	t
1429	256	5	06:00:00	22:00:00	2026-10-25	\N	t
1430	257	1	09:00:00	18:00:00	2026-10-25	\N	t
1431	257	2	09:00:00	18:00:00	2026-10-25	\N	t
1432	257	3	09:00:00	18:00:00	2026-10-25	\N	t
1433	257	4	09:00:00	18:00:00	2026-10-25	\N	t
1434	257	5	09:00:00	18:00:00	2026-10-25	\N	t
1435	257	6	09:00:00	18:00:00	2026-10-25	\N	t
1436	258	1	06:00:00	22:00:00	2026-10-25	\N	t
1437	258	2	06:00:00	22:00:00	2026-10-25	\N	t
1438	258	3	06:00:00	22:00:00	2026-10-25	\N	t
1439	258	4	06:00:00	22:00:00	2026-10-25	\N	t
1440	258	5	06:00:00	22:00:00	2026-10-25	\N	t
1441	259	1	09:00:00	18:00:00	2026-10-25	\N	t
1442	259	2	09:00:00	18:00:00	2026-10-25	\N	t
1443	259	3	09:00:00	18:00:00	2026-10-25	\N	t
1444	259	4	09:00:00	18:00:00	2026-10-25	\N	t
1445	259	5	09:00:00	18:00:00	2026-10-25	\N	t
1446	259	6	09:00:00	18:00:00	2026-10-25	\N	t
1447	260	1	06:00:00	22:00:00	2026-10-25	\N	t
1448	260	2	06:00:00	22:00:00	2026-10-25	\N	t
1449	260	3	06:00:00	22:00:00	2026-10-25	\N	t
1450	260	4	06:00:00	22:00:00	2026-10-25	\N	t
1451	260	5	06:00:00	22:00:00	2026-10-25	\N	t
1452	261	1	09:00:00	18:00:00	2026-10-25	\N	t
1453	261	2	09:00:00	18:00:00	2026-10-25	\N	t
1454	261	3	09:00:00	18:00:00	2026-10-25	\N	t
1455	261	4	09:00:00	18:00:00	2026-10-25	\N	t
1456	261	5	09:00:00	18:00:00	2026-10-25	\N	t
1457	261	6	09:00:00	18:00:00	2026-10-25	\N	t
1458	262	1	09:00:00	18:00:00	2026-10-25	\N	t
1459	262	2	09:00:00	18:00:00	2026-10-25	\N	t
1460	262	3	09:00:00	18:00:00	2026-10-25	\N	t
1461	262	4	09:00:00	18:00:00	2026-10-25	\N	t
1462	262	5	09:00:00	18:00:00	2026-10-25	\N	t
1463	262	6	09:00:00	18:00:00	2026-10-25	\N	t
1464	263	1	06:00:00	22:00:00	2026-10-25	\N	t
1465	263	2	06:00:00	22:00:00	2026-10-25	\N	t
1466	263	3	06:00:00	22:00:00	2026-10-25	\N	t
1467	263	4	06:00:00	22:00:00	2026-10-25	\N	t
1468	263	5	06:00:00	22:00:00	2026-10-25	\N	t
1469	264	1	09:00:00	18:00:00	2026-10-25	\N	t
1470	264	2	09:00:00	18:00:00	2026-10-25	\N	t
1471	264	3	09:00:00	18:00:00	2026-10-25	\N	t
1472	264	4	09:00:00	18:00:00	2026-10-25	\N	t
1473	264	5	09:00:00	18:00:00	2026-10-25	\N	t
1474	264	6	09:00:00	18:00:00	2026-10-25	\N	t
1475	265	1	09:00:00	18:00:00	2026-10-25	\N	t
1476	265	2	09:00:00	18:00:00	2026-10-25	\N	t
1477	265	3	09:00:00	18:00:00	2026-10-25	\N	t
1478	265	4	09:00:00	18:00:00	2026-10-25	\N	t
1479	265	5	09:00:00	18:00:00	2026-10-25	\N	t
1480	265	6	09:00:00	18:00:00	2026-10-25	\N	t
1481	266	1	06:00:00	22:00:00	2026-10-25	\N	t
1482	266	2	06:00:00	22:00:00	2026-10-25	\N	t
1483	266	3	06:00:00	22:00:00	2026-10-25	\N	t
1484	266	4	06:00:00	22:00:00	2026-10-25	\N	t
1485	266	5	06:00:00	22:00:00	2026-10-25	\N	t
1486	267	1	09:00:00	18:00:00	2026-10-25	\N	t
1487	267	2	09:00:00	18:00:00	2026-10-25	\N	t
1488	267	3	09:00:00	18:00:00	2026-10-25	\N	t
1489	267	4	09:00:00	18:00:00	2026-10-25	\N	t
1490	267	5	09:00:00	18:00:00	2026-10-25	\N	t
1491	267	6	09:00:00	18:00:00	2026-10-25	\N	t
1492	268	1	06:00:00	22:00:00	2026-10-25	\N	t
1493	268	2	06:00:00	22:00:00	2026-10-25	\N	t
1494	268	3	06:00:00	22:00:00	2026-10-25	\N	t
1495	268	4	06:00:00	22:00:00	2026-10-25	\N	t
1496	268	5	06:00:00	22:00:00	2026-10-25	\N	t
1497	269	1	09:00:00	18:00:00	2026-10-25	\N	t
1498	269	2	09:00:00	18:00:00	2026-10-25	\N	t
1499	269	3	09:00:00	18:00:00	2026-10-25	\N	t
1500	269	4	09:00:00	18:00:00	2026-10-25	\N	t
1501	269	5	09:00:00	18:00:00	2026-10-25	\N	t
1502	269	6	09:00:00	18:00:00	2026-10-25	\N	t
1503	270	1	06:00:00	22:00:00	2026-10-25	\N	t
1504	270	2	06:00:00	22:00:00	2026-10-25	\N	t
1505	270	3	06:00:00	22:00:00	2026-10-25	\N	t
1506	270	4	06:00:00	22:00:00	2026-10-25	\N	t
1507	270	5	06:00:00	22:00:00	2026-10-25	\N	t
1508	271	1	09:00:00	18:00:00	2026-10-25	\N	t
1509	271	2	09:00:00	18:00:00	2026-10-25	\N	t
1510	271	3	09:00:00	18:00:00	2026-10-25	\N	t
1511	271	4	09:00:00	18:00:00	2026-10-25	\N	t
1512	271	5	09:00:00	18:00:00	2026-10-25	\N	t
1513	271	6	09:00:00	18:00:00	2026-10-25	\N	t
1514	272	1	06:00:00	22:00:00	2026-10-25	\N	t
1515	272	2	06:00:00	22:00:00	2026-10-25	\N	t
1516	272	3	06:00:00	22:00:00	2026-10-25	\N	t
1517	272	4	06:00:00	22:00:00	2026-10-25	\N	t
1518	272	5	06:00:00	22:00:00	2026-10-25	\N	t
1519	273	1	09:00:00	18:00:00	2026-10-25	\N	t
1520	273	2	09:00:00	18:00:00	2026-10-25	\N	t
1521	273	3	09:00:00	18:00:00	2026-10-25	\N	t
1522	273	4	09:00:00	18:00:00	2026-10-25	\N	t
1523	273	5	09:00:00	18:00:00	2026-10-25	\N	t
1524	273	6	09:00:00	18:00:00	2026-10-25	\N	t
1525	274	1	09:00:00	18:00:00	2026-10-25	\N	t
1526	274	2	09:00:00	18:00:00	2026-10-25	\N	t
1527	274	3	09:00:00	18:00:00	2026-10-25	\N	t
1528	274	4	09:00:00	18:00:00	2026-10-25	\N	t
1529	274	5	09:00:00	18:00:00	2026-10-25	\N	t
1530	274	6	09:00:00	18:00:00	2026-10-25	\N	t
1531	275	1	06:00:00	22:00:00	2026-10-25	\N	t
1532	275	2	06:00:00	22:00:00	2026-10-25	\N	t
1533	275	3	06:00:00	22:00:00	2026-10-25	\N	t
1534	275	4	06:00:00	22:00:00	2026-10-25	\N	t
1535	275	5	06:00:00	22:00:00	2026-10-25	\N	t
1536	276	1	09:00:00	18:00:00	2026-10-25	\N	t
1537	276	2	09:00:00	18:00:00	2026-10-25	\N	t
1538	276	3	09:00:00	18:00:00	2026-10-25	\N	t
1539	276	4	09:00:00	18:00:00	2026-10-25	\N	t
1540	276	5	09:00:00	18:00:00	2026-10-25	\N	t
1541	276	6	09:00:00	18:00:00	2026-10-25	\N	t
1542	277	1	09:00:00	18:00:00	2026-10-25	\N	t
1543	277	2	09:00:00	18:00:00	2026-10-25	\N	t
1544	277	3	09:00:00	18:00:00	2026-10-25	\N	t
1545	277	4	09:00:00	18:00:00	2026-10-25	\N	t
1546	277	5	09:00:00	18:00:00	2026-10-25	\N	t
1547	277	6	09:00:00	18:00:00	2026-10-25	\N	t
1548	278	1	06:00:00	22:00:00	2026-10-25	\N	t
1549	278	2	06:00:00	22:00:00	2026-10-25	\N	t
1550	278	3	06:00:00	22:00:00	2026-10-25	\N	t
1551	278	4	06:00:00	22:00:00	2026-10-25	\N	t
1552	278	5	06:00:00	22:00:00	2026-10-25	\N	t
1553	279	1	09:00:00	18:00:00	2026-10-25	\N	t
1554	279	2	09:00:00	18:00:00	2026-10-25	\N	t
1555	279	3	09:00:00	18:00:00	2026-10-25	\N	t
1556	279	4	09:00:00	18:00:00	2026-10-25	\N	t
1557	279	5	09:00:00	18:00:00	2026-10-25	\N	t
1558	279	6	09:00:00	18:00:00	2026-10-25	\N	t
1559	280	1	06:00:00	22:00:00	2026-10-25	\N	t
1560	280	2	06:00:00	22:00:00	2026-10-25	\N	t
1561	280	3	06:00:00	22:00:00	2026-10-25	\N	t
1562	280	4	06:00:00	22:00:00	2026-10-25	\N	t
1563	280	5	06:00:00	22:00:00	2026-10-25	\N	t
1564	281	1	09:00:00	18:00:00	2026-10-25	\N	t
1565	281	2	09:00:00	18:00:00	2026-10-25	\N	t
1566	281	3	09:00:00	18:00:00	2026-10-25	\N	t
1567	281	4	09:00:00	18:00:00	2026-10-25	\N	t
1568	281	5	09:00:00	18:00:00	2026-10-25	\N	t
1569	281	6	09:00:00	18:00:00	2026-10-25	\N	t
1570	282	1	06:00:00	22:00:00	2026-10-25	\N	t
1571	282	2	06:00:00	22:00:00	2026-10-25	\N	t
1572	282	3	06:00:00	22:00:00	2026-10-25	\N	t
1573	282	4	06:00:00	22:00:00	2026-10-25	\N	t
1574	282	5	06:00:00	22:00:00	2026-10-25	\N	t
1575	283	1	09:00:00	18:00:00	2026-10-25	\N	t
1576	283	2	09:00:00	18:00:00	2026-10-25	\N	t
1577	283	3	09:00:00	18:00:00	2026-10-25	\N	t
1578	283	4	09:00:00	18:00:00	2026-10-25	\N	t
1579	283	5	09:00:00	18:00:00	2026-10-25	\N	t
1580	283	6	09:00:00	18:00:00	2026-10-25	\N	t
1581	284	1	06:00:00	22:00:00	2026-10-25	\N	t
1582	284	2	06:00:00	22:00:00	2026-10-25	\N	t
1583	284	3	06:00:00	22:00:00	2026-10-25	\N	t
1584	284	4	06:00:00	22:00:00	2026-10-25	\N	t
1585	284	5	06:00:00	22:00:00	2026-10-25	\N	t
1586	285	1	09:00:00	18:00:00	2026-10-25	\N	t
1587	285	2	09:00:00	18:00:00	2026-10-25	\N	t
1588	285	3	09:00:00	18:00:00	2026-10-25	\N	t
1589	285	4	09:00:00	18:00:00	2026-10-25	\N	t
1590	285	5	09:00:00	18:00:00	2026-10-25	\N	t
1591	285	6	09:00:00	18:00:00	2026-10-25	\N	t
1592	286	1	09:00:00	18:00:00	2026-10-25	\N	t
1593	286	2	09:00:00	18:00:00	2026-10-25	\N	t
1594	286	3	09:00:00	18:00:00	2026-10-25	\N	t
1595	286	4	09:00:00	18:00:00	2026-10-25	\N	t
1596	286	5	09:00:00	18:00:00	2026-10-25	\N	t
1597	286	6	09:00:00	18:00:00	2026-10-25	\N	t
1598	287	1	06:00:00	22:00:00	2026-10-25	\N	t
1599	287	2	06:00:00	22:00:00	2026-10-25	\N	t
1600	287	3	06:00:00	22:00:00	2026-10-25	\N	t
1601	287	4	06:00:00	22:00:00	2026-10-25	\N	t
1602	287	5	06:00:00	22:00:00	2026-10-25	\N	t
1603	288	1	09:00:00	18:00:00	2026-10-25	\N	t
1604	288	2	09:00:00	18:00:00	2026-10-25	\N	t
1605	288	3	09:00:00	18:00:00	2026-10-25	\N	t
1606	288	4	09:00:00	18:00:00	2026-10-25	\N	t
1607	288	5	09:00:00	18:00:00	2026-10-25	\N	t
1608	288	6	09:00:00	18:00:00	2026-10-25	\N	t
1609	289	1	09:00:00	18:00:00	2026-10-25	\N	t
1610	289	2	09:00:00	18:00:00	2026-10-25	\N	t
1611	289	3	09:00:00	18:00:00	2026-10-25	\N	t
1612	289	4	09:00:00	18:00:00	2026-10-25	\N	t
1613	289	5	09:00:00	18:00:00	2026-10-25	\N	t
1614	289	6	09:00:00	18:00:00	2026-10-25	\N	t
1615	290	1	06:00:00	22:00:00	2026-10-25	\N	t
1616	290	2	06:00:00	22:00:00	2026-10-25	\N	t
1617	290	3	06:00:00	22:00:00	2026-10-25	\N	t
1618	290	4	06:00:00	22:00:00	2026-10-25	\N	t
1619	290	5	06:00:00	22:00:00	2026-10-25	\N	t
1620	291	1	09:00:00	18:00:00	2026-10-25	\N	t
1621	291	2	09:00:00	18:00:00	2026-10-25	\N	t
1622	291	3	09:00:00	18:00:00	2026-10-25	\N	t
1623	291	4	09:00:00	18:00:00	2026-10-25	\N	t
1624	291	5	09:00:00	18:00:00	2026-10-25	\N	t
1625	291	6	09:00:00	18:00:00	2026-10-25	\N	t
1626	292	1	06:00:00	22:00:00	2026-10-25	\N	t
1627	292	2	06:00:00	22:00:00	2026-10-25	\N	t
1628	292	3	06:00:00	22:00:00	2026-10-25	\N	t
1629	292	4	06:00:00	22:00:00	2026-10-25	\N	t
1630	292	5	06:00:00	22:00:00	2026-10-25	\N	t
1631	293	1	09:00:00	18:00:00	2026-10-25	\N	t
1632	293	2	09:00:00	18:00:00	2026-10-25	\N	t
1633	293	3	09:00:00	18:00:00	2026-10-25	\N	t
1634	293	4	09:00:00	18:00:00	2026-10-25	\N	t
1635	293	5	09:00:00	18:00:00	2026-10-25	\N	t
1636	293	6	09:00:00	18:00:00	2026-10-25	\N	t
1637	294	1	06:00:00	22:00:00	2026-10-25	\N	t
1638	294	2	06:00:00	22:00:00	2026-10-25	\N	t
1639	294	3	06:00:00	22:00:00	2026-10-25	\N	t
1640	294	4	06:00:00	22:00:00	2026-10-25	\N	t
1641	294	5	06:00:00	22:00:00	2026-10-25	\N	t
1642	295	1	09:00:00	18:00:00	2026-10-25	\N	t
1643	295	2	09:00:00	18:00:00	2026-10-25	\N	t
1644	295	3	09:00:00	18:00:00	2026-10-25	\N	t
1645	295	4	09:00:00	18:00:00	2026-10-25	\N	t
1646	295	5	09:00:00	18:00:00	2026-10-25	\N	t
1647	295	6	09:00:00	18:00:00	2026-10-25	\N	t
1648	296	1	06:00:00	22:00:00	2026-10-25	\N	t
1649	296	2	06:00:00	22:00:00	2026-10-25	\N	t
1650	296	3	06:00:00	22:00:00	2026-10-25	\N	t
1651	296	4	06:00:00	22:00:00	2026-10-25	\N	t
1652	296	5	06:00:00	22:00:00	2026-10-25	\N	t
1653	297	1	09:00:00	18:00:00	2026-10-25	\N	t
1654	297	2	09:00:00	18:00:00	2026-10-25	\N	t
1655	297	3	09:00:00	18:00:00	2026-10-25	\N	t
1656	297	4	09:00:00	18:00:00	2026-10-25	\N	t
1657	297	5	09:00:00	18:00:00	2026-10-25	\N	t
1658	297	6	09:00:00	18:00:00	2026-10-25	\N	t
1659	298	1	09:00:00	18:00:00	2026-10-25	\N	t
1660	298	2	09:00:00	18:00:00	2026-10-25	\N	t
1661	298	3	09:00:00	18:00:00	2026-10-25	\N	t
1662	298	4	09:00:00	18:00:00	2026-10-25	\N	t
1663	298	5	09:00:00	18:00:00	2026-10-25	\N	t
1664	298	6	09:00:00	18:00:00	2026-10-25	\N	t
1665	299	1	06:00:00	22:00:00	2026-10-25	\N	t
1666	299	2	06:00:00	22:00:00	2026-10-25	\N	t
1667	299	3	06:00:00	22:00:00	2026-10-25	\N	t
1668	299	4	06:00:00	22:00:00	2026-10-25	\N	t
1669	299	5	06:00:00	22:00:00	2026-10-25	\N	t
1670	300	1	09:00:00	18:00:00	2026-10-25	\N	t
1671	300	2	09:00:00	18:00:00	2026-10-25	\N	t
1672	300	3	09:00:00	18:00:00	2026-10-25	\N	t
1673	300	4	09:00:00	18:00:00	2026-10-25	\N	t
1674	300	5	09:00:00	18:00:00	2026-10-25	\N	t
1675	300	6	09:00:00	18:00:00	2026-10-25	\N	t
1676	301	1	09:00:00	18:00:00	2026-10-25	\N	t
1677	301	2	09:00:00	18:00:00	2026-10-25	\N	t
1678	301	3	09:00:00	18:00:00	2026-10-25	\N	t
1679	301	4	09:00:00	18:00:00	2026-10-25	\N	t
1680	301	5	09:00:00	18:00:00	2026-10-25	\N	t
1681	301	6	09:00:00	18:00:00	2026-10-25	\N	t
1682	302	1	06:00:00	22:00:00	2026-10-25	\N	t
1683	302	2	06:00:00	22:00:00	2026-10-25	\N	t
1684	302	3	06:00:00	22:00:00	2026-10-25	\N	t
1685	302	4	06:00:00	22:00:00	2026-10-25	\N	t
1686	302	5	06:00:00	22:00:00	2026-10-25	\N	t
1687	303	1	09:00:00	18:00:00	2026-10-25	\N	t
1688	303	2	09:00:00	18:00:00	2026-10-25	\N	t
1689	303	3	09:00:00	18:00:00	2026-10-25	\N	t
1690	303	4	09:00:00	18:00:00	2026-10-25	\N	t
1691	303	5	09:00:00	18:00:00	2026-10-25	\N	t
1692	303	6	09:00:00	18:00:00	2026-10-25	\N	t
1693	304	1	06:00:00	22:00:00	2026-10-25	\N	t
1694	304	2	06:00:00	22:00:00	2026-10-25	\N	t
1695	304	3	06:00:00	22:00:00	2026-10-25	\N	t
1696	304	4	06:00:00	22:00:00	2026-10-25	\N	t
1697	304	5	06:00:00	22:00:00	2026-10-25	\N	t
1698	305	1	09:00:00	18:00:00	2026-10-25	\N	t
1699	305	2	09:00:00	18:00:00	2026-10-25	\N	t
1700	305	3	09:00:00	18:00:00	2026-10-25	\N	t
1701	305	4	09:00:00	18:00:00	2026-10-25	\N	t
1702	305	5	09:00:00	18:00:00	2026-10-25	\N	t
1703	305	6	09:00:00	18:00:00	2026-10-25	\N	t
1704	306	1	06:00:00	22:00:00	2026-10-25	\N	t
1705	306	2	06:00:00	22:00:00	2026-10-25	\N	t
1706	306	3	06:00:00	22:00:00	2026-10-25	\N	t
1707	306	4	06:00:00	22:00:00	2026-10-25	\N	t
1708	306	5	06:00:00	22:00:00	2026-10-25	\N	t
1709	307	1	09:00:00	18:00:00	2026-10-25	\N	t
1710	307	2	09:00:00	18:00:00	2026-10-25	\N	t
1711	307	3	09:00:00	18:00:00	2026-10-25	\N	t
1712	307	4	09:00:00	18:00:00	2026-10-25	\N	t
1713	307	5	09:00:00	18:00:00	2026-10-25	\N	t
1714	307	6	09:00:00	18:00:00	2026-10-25	\N	t
1715	308	1	06:00:00	22:00:00	2026-10-25	\N	t
1716	308	2	06:00:00	22:00:00	2026-10-25	\N	t
1717	308	3	06:00:00	22:00:00	2026-10-25	\N	t
1718	308	4	06:00:00	22:00:00	2026-10-25	\N	t
1719	308	5	06:00:00	22:00:00	2026-10-25	\N	t
1720	309	1	09:00:00	18:00:00	2026-10-25	\N	t
1721	309	2	09:00:00	18:00:00	2026-10-25	\N	t
1722	309	3	09:00:00	18:00:00	2026-10-25	\N	t
1723	309	4	09:00:00	18:00:00	2026-10-25	\N	t
1724	309	5	09:00:00	18:00:00	2026-10-25	\N	t
1725	309	6	09:00:00	18:00:00	2026-10-25	\N	t
1726	310	1	09:00:00	18:00:00	2026-10-25	\N	t
1727	310	2	09:00:00	18:00:00	2026-10-25	\N	t
1728	310	3	09:00:00	18:00:00	2026-10-25	\N	t
1729	310	4	09:00:00	18:00:00	2026-10-25	\N	t
1730	310	5	09:00:00	18:00:00	2026-10-25	\N	t
1731	310	6	09:00:00	18:00:00	2026-10-25	\N	t
1732	311	1	06:00:00	22:00:00	2026-10-25	\N	t
1733	311	2	06:00:00	22:00:00	2026-10-25	\N	t
1734	311	3	06:00:00	22:00:00	2026-10-25	\N	t
1735	311	4	06:00:00	22:00:00	2026-10-25	\N	t
1736	311	5	06:00:00	22:00:00	2026-10-25	\N	t
1737	312	1	09:00:00	18:00:00	2026-10-25	\N	t
1738	312	2	09:00:00	18:00:00	2026-10-25	\N	t
1739	312	3	09:00:00	18:00:00	2026-10-25	\N	t
1740	312	4	09:00:00	18:00:00	2026-10-25	\N	t
1741	312	5	09:00:00	18:00:00	2026-10-25	\N	t
1742	312	6	09:00:00	18:00:00	2026-10-25	\N	t
1743	313	1	09:00:00	18:00:00	2026-10-25	\N	t
1744	313	2	09:00:00	18:00:00	2026-10-25	\N	t
1745	313	3	09:00:00	18:00:00	2026-10-25	\N	t
1746	313	4	09:00:00	18:00:00	2026-10-25	\N	t
1747	313	5	09:00:00	18:00:00	2026-10-25	\N	t
1748	313	6	09:00:00	18:00:00	2026-10-25	\N	t
1749	314	1	06:00:00	22:00:00	2026-10-25	\N	t
1750	314	2	06:00:00	22:00:00	2026-10-25	\N	t
1751	314	3	06:00:00	22:00:00	2026-10-25	\N	t
1752	314	4	06:00:00	22:00:00	2026-10-25	\N	t
1753	314	5	06:00:00	22:00:00	2026-10-25	\N	t
1754	315	1	09:00:00	18:00:00	2026-10-25	\N	t
1755	315	2	09:00:00	18:00:00	2026-10-25	\N	t
1756	315	3	09:00:00	18:00:00	2026-10-25	\N	t
1757	315	4	09:00:00	18:00:00	2026-10-25	\N	t
1758	315	5	09:00:00	18:00:00	2026-10-25	\N	t
1759	315	6	09:00:00	18:00:00	2026-10-25	\N	t
1760	316	1	06:00:00	22:00:00	2026-10-25	\N	t
1761	316	2	06:00:00	22:00:00	2026-10-25	\N	t
1762	316	3	06:00:00	22:00:00	2026-10-25	\N	t
1763	316	4	06:00:00	22:00:00	2026-10-25	\N	t
1764	316	5	06:00:00	22:00:00	2026-10-25	\N	t
1765	317	1	09:00:00	18:00:00	2026-10-25	\N	t
1766	317	2	09:00:00	18:00:00	2026-10-25	\N	t
1767	317	3	09:00:00	18:00:00	2026-10-25	\N	t
1768	317	4	09:00:00	18:00:00	2026-10-25	\N	t
1769	317	5	09:00:00	18:00:00	2026-10-25	\N	t
1770	317	6	09:00:00	18:00:00	2026-10-25	\N	t
1771	318	1	06:00:00	22:00:00	2026-10-25	\N	t
1772	318	2	06:00:00	22:00:00	2026-10-25	\N	t
1773	318	3	06:00:00	22:00:00	2026-10-25	\N	t
1774	318	4	06:00:00	22:00:00	2026-10-25	\N	t
1775	318	5	06:00:00	22:00:00	2026-10-25	\N	t
1776	319	1	09:00:00	18:00:00	2026-10-25	\N	t
1777	319	2	09:00:00	18:00:00	2026-10-25	\N	t
1778	319	3	09:00:00	18:00:00	2026-10-25	\N	t
1779	319	4	09:00:00	18:00:00	2026-10-25	\N	t
1780	319	5	09:00:00	18:00:00	2026-10-25	\N	t
1781	319	6	09:00:00	18:00:00	2026-10-25	\N	t
1782	320	1	06:00:00	22:00:00	2026-10-25	\N	t
1783	320	2	06:00:00	22:00:00	2026-10-25	\N	t
1784	320	3	06:00:00	22:00:00	2026-10-25	\N	t
1785	320	4	06:00:00	22:00:00	2026-10-25	\N	t
1786	320	5	06:00:00	22:00:00	2026-10-25	\N	t
1787	321	1	09:00:00	18:00:00	2026-10-25	\N	t
1788	321	2	09:00:00	18:00:00	2026-10-25	\N	t
1789	321	3	09:00:00	18:00:00	2026-10-25	\N	t
1790	321	4	09:00:00	18:00:00	2026-10-25	\N	t
1791	321	5	09:00:00	18:00:00	2026-10-25	\N	t
1792	321	6	09:00:00	18:00:00	2026-10-25	\N	t
1793	322	1	09:00:00	18:00:00	2026-10-25	\N	t
1794	322	2	09:00:00	18:00:00	2026-10-25	\N	t
1795	322	3	09:00:00	18:00:00	2026-10-25	\N	t
1796	322	4	09:00:00	18:00:00	2026-10-25	\N	t
1797	322	5	09:00:00	18:00:00	2026-10-25	\N	t
1798	322	6	09:00:00	18:00:00	2026-10-25	\N	t
1799	323	1	06:00:00	22:00:00	2026-10-25	\N	t
1800	323	2	06:00:00	22:00:00	2026-10-25	\N	t
1801	323	3	06:00:00	22:00:00	2026-10-25	\N	t
1802	323	4	06:00:00	22:00:00	2026-10-25	\N	t
1803	323	5	06:00:00	22:00:00	2026-10-25	\N	t
1804	324	1	09:00:00	18:00:00	2026-10-25	\N	t
1805	324	2	09:00:00	18:00:00	2026-10-25	\N	t
1806	324	3	09:00:00	18:00:00	2026-10-25	\N	t
1807	324	4	09:00:00	18:00:00	2026-10-25	\N	t
1808	324	5	09:00:00	18:00:00	2026-10-25	\N	t
1809	324	6	09:00:00	18:00:00	2026-10-25	\N	t
1810	325	1	09:00:00	18:00:00	2026-10-25	\N	t
1811	325	2	09:00:00	18:00:00	2026-10-25	\N	t
1812	325	3	09:00:00	18:00:00	2026-10-25	\N	t
1813	325	4	09:00:00	18:00:00	2026-10-25	\N	t
1814	325	5	09:00:00	18:00:00	2026-10-25	\N	t
1815	325	6	09:00:00	18:00:00	2026-10-25	\N	t
1816	326	1	06:00:00	22:00:00	2026-10-25	\N	t
1817	326	2	06:00:00	22:00:00	2026-10-25	\N	t
1818	326	3	06:00:00	22:00:00	2026-10-25	\N	t
1819	326	4	06:00:00	22:00:00	2026-10-25	\N	t
1820	326	5	06:00:00	22:00:00	2026-10-25	\N	t
1821	327	1	09:00:00	18:00:00	2026-10-25	\N	t
1822	327	2	09:00:00	18:00:00	2026-10-25	\N	t
1823	327	3	09:00:00	18:00:00	2026-10-25	\N	t
1824	327	4	09:00:00	18:00:00	2026-10-25	\N	t
1825	327	5	09:00:00	18:00:00	2026-10-25	\N	t
1826	327	6	09:00:00	18:00:00	2026-10-25	\N	t
1827	328	1	06:00:00	22:00:00	2026-10-25	\N	t
1828	328	2	06:00:00	22:00:00	2026-10-25	\N	t
1829	328	3	06:00:00	22:00:00	2026-10-25	\N	t
1830	328	4	06:00:00	22:00:00	2026-10-25	\N	t
1831	328	5	06:00:00	22:00:00	2026-10-25	\N	t
1832	329	1	09:00:00	18:00:00	2026-10-25	\N	t
1833	329	2	09:00:00	18:00:00	2026-10-25	\N	t
1834	329	3	09:00:00	18:00:00	2026-10-25	\N	t
1835	329	4	09:00:00	18:00:00	2026-10-25	\N	t
1836	329	5	09:00:00	18:00:00	2026-10-25	\N	t
1837	329	6	09:00:00	18:00:00	2026-10-25	\N	t
1838	330	1	06:00:00	22:00:00	2026-10-25	\N	t
1839	330	2	06:00:00	22:00:00	2026-10-25	\N	t
1840	330	3	06:00:00	22:00:00	2026-10-25	\N	t
1841	330	4	06:00:00	22:00:00	2026-10-25	\N	t
1842	330	5	06:00:00	22:00:00	2026-10-25	\N	t
1843	331	1	09:00:00	18:00:00	2026-10-25	\N	t
1844	331	2	09:00:00	18:00:00	2026-10-25	\N	t
1845	331	3	09:00:00	18:00:00	2026-10-25	\N	t
1846	331	4	09:00:00	18:00:00	2026-10-25	\N	t
1847	331	5	09:00:00	18:00:00	2026-10-25	\N	t
1848	331	6	09:00:00	18:00:00	2026-10-25	\N	t
1849	332	1	06:00:00	22:00:00	2026-10-25	\N	t
1850	332	2	06:00:00	22:00:00	2026-10-25	\N	t
1851	332	3	06:00:00	22:00:00	2026-10-25	\N	t
1852	332	4	06:00:00	22:00:00	2026-10-25	\N	t
1853	332	5	06:00:00	22:00:00	2026-10-25	\N	t
1854	333	1	09:00:00	18:00:00	2026-10-25	\N	t
1855	333	2	09:00:00	18:00:00	2026-10-25	\N	t
1856	333	3	09:00:00	18:00:00	2026-10-25	\N	t
1857	333	4	09:00:00	18:00:00	2026-10-25	\N	t
1858	333	5	09:00:00	18:00:00	2026-10-25	\N	t
1859	333	6	09:00:00	18:00:00	2026-10-25	\N	t
1860	334	1	09:00:00	18:00:00	2026-10-25	\N	t
1861	334	2	09:00:00	18:00:00	2026-10-25	\N	t
1862	334	3	09:00:00	18:00:00	2026-10-25	\N	t
1863	334	4	09:00:00	18:00:00	2026-10-25	\N	t
1864	334	5	09:00:00	18:00:00	2026-10-25	\N	t
1865	334	6	09:00:00	18:00:00	2026-10-25	\N	t
1866	335	1	06:00:00	22:00:00	2026-10-25	\N	t
1867	335	2	06:00:00	22:00:00	2026-10-25	\N	t
1868	335	3	06:00:00	22:00:00	2026-10-25	\N	t
1869	335	4	06:00:00	22:00:00	2026-10-25	\N	t
1870	335	5	06:00:00	22:00:00	2026-10-25	\N	t
1871	336	1	09:00:00	18:00:00	2026-10-25	\N	t
1872	336	2	09:00:00	18:00:00	2026-10-25	\N	t
1873	336	3	09:00:00	18:00:00	2026-10-25	\N	t
1874	336	4	09:00:00	18:00:00	2026-10-25	\N	t
1875	336	5	09:00:00	18:00:00	2026-10-25	\N	t
1876	336	6	09:00:00	18:00:00	2026-10-25	\N	t
1877	337	1	09:00:00	18:00:00	2026-10-25	\N	t
1878	337	2	09:00:00	18:00:00	2026-10-25	\N	t
1879	337	3	09:00:00	18:00:00	2026-10-25	\N	t
1880	337	4	09:00:00	18:00:00	2026-10-25	\N	t
1881	337	5	09:00:00	18:00:00	2026-10-25	\N	t
1882	337	6	09:00:00	18:00:00	2026-10-25	\N	t
1883	338	1	06:00:00	22:00:00	2026-10-25	\N	t
1884	338	2	06:00:00	22:00:00	2026-10-25	\N	t
1885	338	3	06:00:00	22:00:00	2026-10-25	\N	t
1886	338	4	06:00:00	22:00:00	2026-10-25	\N	t
1887	338	5	06:00:00	22:00:00	2026-10-25	\N	t
1888	339	1	09:00:00	18:00:00	2026-10-25	\N	t
1889	339	2	09:00:00	18:00:00	2026-10-25	\N	t
1890	339	3	09:00:00	18:00:00	2026-10-25	\N	t
1891	339	4	09:00:00	18:00:00	2026-10-25	\N	t
1892	339	5	09:00:00	18:00:00	2026-10-25	\N	t
1893	339	6	09:00:00	18:00:00	2026-10-25	\N	t
1894	340	1	06:00:00	22:00:00	2026-10-25	\N	t
1895	340	2	06:00:00	22:00:00	2026-10-25	\N	t
1896	340	3	06:00:00	22:00:00	2026-10-25	\N	t
1897	340	4	06:00:00	22:00:00	2026-10-25	\N	t
1898	340	5	06:00:00	22:00:00	2026-10-25	\N	t
1899	341	1	09:00:00	18:00:00	2026-10-25	\N	t
1900	341	2	09:00:00	18:00:00	2026-10-25	\N	t
1901	341	3	09:00:00	18:00:00	2026-10-25	\N	t
1902	341	4	09:00:00	18:00:00	2026-10-25	\N	t
1903	341	5	09:00:00	18:00:00	2026-10-25	\N	t
1904	341	6	09:00:00	18:00:00	2026-10-25	\N	t
1905	342	1	06:00:00	22:00:00	2026-10-25	\N	t
1906	342	2	06:00:00	22:00:00	2026-10-25	\N	t
1907	342	3	06:00:00	22:00:00	2026-10-25	\N	t
1908	342	4	06:00:00	22:00:00	2026-10-25	\N	t
1909	342	5	06:00:00	22:00:00	2026-10-25	\N	t
1910	343	1	09:00:00	18:00:00	2026-10-25	\N	t
1911	343	2	09:00:00	18:00:00	2026-10-25	\N	t
1912	343	3	09:00:00	18:00:00	2026-10-25	\N	t
1913	343	4	09:00:00	18:00:00	2026-10-25	\N	t
1914	343	5	09:00:00	18:00:00	2026-10-25	\N	t
1915	343	6	09:00:00	18:00:00	2026-10-25	\N	t
1916	344	1	06:00:00	22:00:00	2026-10-25	\N	t
1917	344	2	06:00:00	22:00:00	2026-10-25	\N	t
1918	344	3	06:00:00	22:00:00	2026-10-25	\N	t
1919	344	4	06:00:00	22:00:00	2026-10-25	\N	t
1920	344	5	06:00:00	22:00:00	2026-10-25	\N	t
1921	345	1	09:00:00	18:00:00	2026-10-25	\N	t
1922	345	2	09:00:00	18:00:00	2026-10-25	\N	t
1923	345	3	09:00:00	18:00:00	2026-10-25	\N	t
1924	345	4	09:00:00	18:00:00	2026-10-25	\N	t
1925	345	5	09:00:00	18:00:00	2026-10-25	\N	t
1926	345	6	09:00:00	18:00:00	2026-10-25	\N	t
1927	346	1	09:00:00	18:00:00	2026-10-25	\N	t
1928	346	2	09:00:00	18:00:00	2026-10-25	\N	t
1929	346	3	09:00:00	18:00:00	2026-10-25	\N	t
1930	346	4	09:00:00	18:00:00	2026-10-25	\N	t
1931	346	5	09:00:00	18:00:00	2026-10-25	\N	t
1932	346	6	09:00:00	18:00:00	2026-10-25	\N	t
1933	347	1	06:00:00	22:00:00	2026-10-25	\N	t
1934	347	2	06:00:00	22:00:00	2026-10-25	\N	t
1935	347	3	06:00:00	22:00:00	2026-10-25	\N	t
1936	347	4	06:00:00	22:00:00	2026-10-25	\N	t
1937	347	5	06:00:00	22:00:00	2026-10-25	\N	t
1938	348	1	09:00:00	18:00:00	2026-10-25	\N	t
1939	348	2	09:00:00	18:00:00	2026-10-25	\N	t
1940	348	3	09:00:00	18:00:00	2026-10-25	\N	t
1941	348	4	09:00:00	18:00:00	2026-10-25	\N	t
1942	348	5	09:00:00	18:00:00	2026-10-25	\N	t
1943	348	6	09:00:00	18:00:00	2026-10-25	\N	t
1944	349	1	09:00:00	18:00:00	2026-10-25	\N	t
1945	349	2	09:00:00	18:00:00	2026-10-25	\N	t
1946	349	3	09:00:00	18:00:00	2026-10-25	\N	t
1947	349	4	09:00:00	18:00:00	2026-10-25	\N	t
1948	349	5	09:00:00	18:00:00	2026-10-25	\N	t
1949	349	6	09:00:00	18:00:00	2026-10-25	\N	t
1950	350	1	06:00:00	22:00:00	2026-10-25	\N	t
1951	350	2	06:00:00	22:00:00	2026-10-25	\N	t
1952	350	3	06:00:00	22:00:00	2026-10-25	\N	t
1953	350	4	06:00:00	22:00:00	2026-10-25	\N	t
1954	350	5	06:00:00	22:00:00	2026-10-25	\N	t
1955	351	1	09:00:00	18:00:00	2026-10-25	\N	t
1956	351	2	09:00:00	18:00:00	2026-10-25	\N	t
1957	351	3	09:00:00	18:00:00	2026-10-25	\N	t
1958	351	4	09:00:00	18:00:00	2026-10-25	\N	t
1959	351	5	09:00:00	18:00:00	2026-10-25	\N	t
1960	351	6	09:00:00	18:00:00	2026-10-25	\N	t
1961	352	1	06:00:00	22:00:00	2026-10-25	\N	t
1962	352	2	06:00:00	22:00:00	2026-10-25	\N	t
1963	352	3	06:00:00	22:00:00	2026-10-25	\N	t
1964	352	4	06:00:00	22:00:00	2026-10-25	\N	t
1965	352	5	06:00:00	22:00:00	2026-10-25	\N	t
1966	353	1	09:00:00	18:00:00	2026-10-25	\N	t
1967	353	2	09:00:00	18:00:00	2026-10-25	\N	t
1968	353	3	09:00:00	18:00:00	2026-10-25	\N	t
1969	353	4	09:00:00	18:00:00	2026-10-25	\N	t
1970	353	5	09:00:00	18:00:00	2026-10-25	\N	t
1971	353	6	09:00:00	18:00:00	2026-10-25	\N	t
1972	354	1	06:00:00	22:00:00	2026-10-25	\N	t
1973	354	2	06:00:00	22:00:00	2026-10-25	\N	t
1974	354	3	06:00:00	22:00:00	2026-10-25	\N	t
1975	354	4	06:00:00	22:00:00	2026-10-25	\N	t
1976	354	5	06:00:00	22:00:00	2026-10-25	\N	t
1977	355	1	09:00:00	18:00:00	2026-10-25	\N	t
1978	355	2	09:00:00	18:00:00	2026-10-25	\N	t
1979	355	3	09:00:00	18:00:00	2026-10-25	\N	t
1980	355	4	09:00:00	18:00:00	2026-10-25	\N	t
1981	355	5	09:00:00	18:00:00	2026-10-25	\N	t
1982	355	6	09:00:00	18:00:00	2026-10-25	\N	t
1983	356	1	06:00:00	22:00:00	2026-10-25	\N	t
1984	356	2	06:00:00	22:00:00	2026-10-25	\N	t
1985	356	3	06:00:00	22:00:00	2026-10-25	\N	t
1986	356	4	06:00:00	22:00:00	2026-10-25	\N	t
1987	356	5	06:00:00	22:00:00	2026-10-25	\N	t
1988	357	1	09:00:00	18:00:00	2026-10-25	\N	t
1989	357	2	09:00:00	18:00:00	2026-10-25	\N	t
1990	357	3	09:00:00	18:00:00	2026-10-25	\N	t
1991	357	4	09:00:00	18:00:00	2026-10-25	\N	t
1992	357	5	09:00:00	18:00:00	2026-10-25	\N	t
1993	357	6	09:00:00	18:00:00	2026-10-25	\N	t
1994	358	1	09:00:00	18:00:00	2026-10-25	\N	t
1995	358	2	09:00:00	18:00:00	2026-10-25	\N	t
1996	358	3	09:00:00	18:00:00	2026-10-25	\N	t
1997	358	4	09:00:00	18:00:00	2026-10-25	\N	t
1998	358	5	09:00:00	18:00:00	2026-10-25	\N	t
1999	358	6	09:00:00	18:00:00	2026-10-25	\N	t
2000	359	1	06:00:00	22:00:00	2026-10-25	\N	t
2001	359	2	06:00:00	22:00:00	2026-10-25	\N	t
2002	359	3	06:00:00	22:00:00	2026-10-25	\N	t
2003	359	4	06:00:00	22:00:00	2026-10-25	\N	t
2004	359	5	06:00:00	22:00:00	2026-10-25	\N	t
2005	360	1	09:00:00	18:00:00	2026-10-25	\N	t
2006	360	2	09:00:00	18:00:00	2026-10-25	\N	t
2007	360	3	09:00:00	18:00:00	2026-10-25	\N	t
2008	360	4	09:00:00	18:00:00	2026-10-25	\N	t
2009	360	5	09:00:00	18:00:00	2026-10-25	\N	t
2010	360	6	09:00:00	18:00:00	2026-10-25	\N	t
2011	361	1	09:00:00	18:00:00	2026-10-25	\N	t
2012	361	2	09:00:00	18:00:00	2026-10-25	\N	t
2013	361	3	09:00:00	18:00:00	2026-10-25	\N	t
2014	361	4	09:00:00	18:00:00	2026-10-25	\N	t
2015	361	5	09:00:00	18:00:00	2026-10-25	\N	t
2016	361	6	09:00:00	18:00:00	2026-10-25	\N	t
2017	362	1	06:00:00	22:00:00	2026-10-25	\N	t
2018	362	2	06:00:00	22:00:00	2026-10-25	\N	t
2019	362	3	06:00:00	22:00:00	2026-10-25	\N	t
2020	362	4	06:00:00	22:00:00	2026-10-25	\N	t
2021	362	5	06:00:00	22:00:00	2026-10-25	\N	t
2022	363	1	09:00:00	18:00:00	2026-10-25	\N	t
2023	363	2	09:00:00	18:00:00	2026-10-25	\N	t
2024	363	3	09:00:00	18:00:00	2026-10-25	\N	t
2025	363	4	09:00:00	18:00:00	2026-10-25	\N	t
2026	363	5	09:00:00	18:00:00	2026-10-25	\N	t
2027	363	6	09:00:00	18:00:00	2026-10-25	\N	t
2028	364	1	06:00:00	22:00:00	2026-10-25	\N	t
2029	364	2	06:00:00	22:00:00	2026-10-25	\N	t
2030	364	3	06:00:00	22:00:00	2026-10-25	\N	t
2031	364	4	06:00:00	22:00:00	2026-10-25	\N	t
2032	364	5	06:00:00	22:00:00	2026-10-25	\N	t
2033	365	1	09:00:00	18:00:00	2026-10-25	\N	t
2034	365	2	09:00:00	18:00:00	2026-10-25	\N	t
2035	365	3	09:00:00	18:00:00	2026-10-25	\N	t
2036	365	4	09:00:00	18:00:00	2026-10-25	\N	t
2037	365	5	09:00:00	18:00:00	2026-10-25	\N	t
2038	365	6	09:00:00	18:00:00	2026-10-25	\N	t
2039	366	1	06:00:00	22:00:00	2026-10-25	\N	t
2040	366	2	06:00:00	22:00:00	2026-10-25	\N	t
2041	366	3	06:00:00	22:00:00	2026-10-25	\N	t
2042	366	4	06:00:00	22:00:00	2026-10-25	\N	t
2043	366	5	06:00:00	22:00:00	2026-10-25	\N	t
2044	367	1	09:00:00	18:00:00	2026-10-25	\N	t
2045	367	2	09:00:00	18:00:00	2026-10-25	\N	t
2046	367	3	09:00:00	18:00:00	2026-10-25	\N	t
2047	367	4	09:00:00	18:00:00	2026-10-25	\N	t
2048	367	5	09:00:00	18:00:00	2026-10-25	\N	t
2049	367	6	09:00:00	18:00:00	2026-10-25	\N	t
2050	368	1	06:00:00	22:00:00	2026-10-25	\N	t
2051	368	2	06:00:00	22:00:00	2026-10-25	\N	t
2052	368	3	06:00:00	22:00:00	2026-10-25	\N	t
2053	368	4	06:00:00	22:00:00	2026-10-25	\N	t
2054	368	5	06:00:00	22:00:00	2026-10-25	\N	t
2055	369	1	09:00:00	18:00:00	2026-10-25	\N	t
2056	369	2	09:00:00	18:00:00	2026-10-25	\N	t
2057	369	3	09:00:00	18:00:00	2026-10-25	\N	t
2058	369	4	09:00:00	18:00:00	2026-10-25	\N	t
2059	369	5	09:00:00	18:00:00	2026-10-25	\N	t
2060	369	6	09:00:00	18:00:00	2026-10-25	\N	t
2061	370	1	09:00:00	18:00:00	2026-10-25	\N	t
2062	370	2	09:00:00	18:00:00	2026-10-25	\N	t
2063	370	3	09:00:00	18:00:00	2026-10-25	\N	t
2064	370	4	09:00:00	18:00:00	2026-10-25	\N	t
2065	370	5	09:00:00	18:00:00	2026-10-25	\N	t
2066	370	6	09:00:00	18:00:00	2026-10-25	\N	t
2067	371	1	06:00:00	22:00:00	2026-10-25	\N	t
2068	371	2	06:00:00	22:00:00	2026-10-25	\N	t
2069	371	3	06:00:00	22:00:00	2026-10-25	\N	t
2070	371	4	06:00:00	22:00:00	2026-10-25	\N	t
2071	371	5	06:00:00	22:00:00	2026-10-25	\N	t
2072	372	1	09:00:00	18:00:00	2026-10-25	\N	t
2073	372	2	09:00:00	18:00:00	2026-10-25	\N	t
2074	372	3	09:00:00	18:00:00	2026-10-25	\N	t
2075	372	4	09:00:00	18:00:00	2026-10-25	\N	t
2076	372	5	09:00:00	18:00:00	2026-10-25	\N	t
2077	372	6	09:00:00	18:00:00	2026-10-25	\N	t
2078	373	1	09:00:00	18:00:00	2026-10-25	\N	t
2079	373	2	09:00:00	18:00:00	2026-10-25	\N	t
2080	373	3	09:00:00	18:00:00	2026-10-25	\N	t
2081	373	4	09:00:00	18:00:00	2026-10-25	\N	t
2082	373	5	09:00:00	18:00:00	2026-10-25	\N	t
2083	373	6	09:00:00	18:00:00	2026-10-25	\N	t
2084	374	1	06:00:00	22:00:00	2026-10-25	\N	t
2085	374	2	06:00:00	22:00:00	2026-10-25	\N	t
2086	374	3	06:00:00	22:00:00	2026-10-25	\N	t
2087	374	4	06:00:00	22:00:00	2026-10-25	\N	t
2088	374	5	06:00:00	22:00:00	2026-10-25	\N	t
2089	375	1	09:00:00	18:00:00	2026-10-25	\N	t
2090	375	2	09:00:00	18:00:00	2026-10-25	\N	t
2091	375	3	09:00:00	18:00:00	2026-10-25	\N	t
2092	375	4	09:00:00	18:00:00	2026-10-25	\N	t
2093	375	5	09:00:00	18:00:00	2026-10-25	\N	t
2094	375	6	09:00:00	18:00:00	2026-10-25	\N	t
2095	376	1	06:00:00	22:00:00	2026-10-25	\N	t
2096	376	2	06:00:00	22:00:00	2026-10-25	\N	t
2097	376	3	06:00:00	22:00:00	2026-10-25	\N	t
2098	376	4	06:00:00	22:00:00	2026-10-25	\N	t
2099	376	5	06:00:00	22:00:00	2026-10-25	\N	t
2100	377	1	09:00:00	18:00:00	2026-10-25	\N	t
2101	377	2	09:00:00	18:00:00	2026-10-25	\N	t
2102	377	3	09:00:00	18:00:00	2026-10-25	\N	t
2103	377	4	09:00:00	18:00:00	2026-10-25	\N	t
2104	377	5	09:00:00	18:00:00	2026-10-25	\N	t
2105	377	6	09:00:00	18:00:00	2026-10-25	\N	t
2106	378	1	06:00:00	22:00:00	2026-10-25	\N	t
2107	378	2	06:00:00	22:00:00	2026-10-25	\N	t
2108	378	3	06:00:00	22:00:00	2026-10-25	\N	t
2109	378	4	06:00:00	22:00:00	2026-10-25	\N	t
2110	378	5	06:00:00	22:00:00	2026-10-25	\N	t
2111	379	1	09:00:00	18:00:00	2026-10-25	\N	t
2112	379	2	09:00:00	18:00:00	2026-10-25	\N	t
2113	379	3	09:00:00	18:00:00	2026-10-25	\N	t
2114	379	4	09:00:00	18:00:00	2026-10-25	\N	t
2115	379	5	09:00:00	18:00:00	2026-10-25	\N	t
2116	379	6	09:00:00	18:00:00	2026-10-25	\N	t
2117	380	1	06:00:00	22:00:00	2026-10-25	\N	t
2118	380	2	06:00:00	22:00:00	2026-10-25	\N	t
2119	380	3	06:00:00	22:00:00	2026-10-25	\N	t
2120	380	4	06:00:00	22:00:00	2026-10-25	\N	t
2121	380	5	06:00:00	22:00:00	2026-10-25	\N	t
2122	381	1	09:00:00	18:00:00	2026-10-25	\N	t
2123	381	2	09:00:00	18:00:00	2026-10-25	\N	t
2124	381	3	09:00:00	18:00:00	2026-10-25	\N	t
2125	381	4	09:00:00	18:00:00	2026-10-25	\N	t
2126	381	5	09:00:00	18:00:00	2026-10-25	\N	t
2127	381	6	09:00:00	18:00:00	2026-10-25	\N	t
2128	382	1	09:00:00	18:00:00	2026-10-25	\N	t
2129	382	2	09:00:00	18:00:00	2026-10-25	\N	t
2130	382	3	09:00:00	18:00:00	2026-10-25	\N	t
2131	382	4	09:00:00	18:00:00	2026-10-25	\N	t
2132	382	5	09:00:00	18:00:00	2026-10-25	\N	t
2133	382	6	09:00:00	18:00:00	2026-10-25	\N	t
2134	383	1	06:00:00	22:00:00	2026-10-25	\N	t
2135	383	2	06:00:00	22:00:00	2026-10-25	\N	t
2136	383	3	06:00:00	22:00:00	2026-10-25	\N	t
2137	383	4	06:00:00	22:00:00	2026-10-25	\N	t
2138	383	5	06:00:00	22:00:00	2026-10-25	\N	t
2139	384	1	09:00:00	18:00:00	2026-10-25	\N	t
2140	384	2	09:00:00	18:00:00	2026-10-25	\N	t
2141	384	3	09:00:00	18:00:00	2026-10-25	\N	t
2142	384	4	09:00:00	18:00:00	2026-10-25	\N	t
2143	384	5	09:00:00	18:00:00	2026-10-25	\N	t
2144	384	6	09:00:00	18:00:00	2026-10-25	\N	t
2145	385	1	09:00:00	18:00:00	2026-10-25	\N	t
2146	385	2	09:00:00	18:00:00	2026-10-25	\N	t
2147	385	3	09:00:00	18:00:00	2026-10-25	\N	t
2148	385	4	09:00:00	18:00:00	2026-10-25	\N	t
2149	385	5	09:00:00	18:00:00	2026-10-25	\N	t
2150	385	6	09:00:00	18:00:00	2026-10-25	\N	t
2151	386	1	06:00:00	22:00:00	2026-10-25	\N	t
2152	386	2	06:00:00	22:00:00	2026-10-25	\N	t
2153	386	3	06:00:00	22:00:00	2026-10-25	\N	t
2154	386	4	06:00:00	22:00:00	2026-10-25	\N	t
2155	386	5	06:00:00	22:00:00	2026-10-25	\N	t
2156	387	1	09:00:00	18:00:00	2026-10-25	\N	t
2157	387	2	09:00:00	18:00:00	2026-10-25	\N	t
2158	387	3	09:00:00	18:00:00	2026-10-25	\N	t
2159	387	4	09:00:00	18:00:00	2026-10-25	\N	t
2160	387	5	09:00:00	18:00:00	2026-10-25	\N	t
2161	387	6	09:00:00	18:00:00	2026-10-25	\N	t
2162	388	1	06:00:00	22:00:00	2026-10-25	\N	t
2163	388	2	06:00:00	22:00:00	2026-10-25	\N	t
2164	388	3	06:00:00	22:00:00	2026-10-25	\N	t
2165	388	4	06:00:00	22:00:00	2026-10-25	\N	t
2166	388	5	06:00:00	22:00:00	2026-10-25	\N	t
2167	389	1	09:00:00	18:00:00	2026-10-25	\N	t
2168	389	2	09:00:00	18:00:00	2026-10-25	\N	t
2169	389	3	09:00:00	18:00:00	2026-10-25	\N	t
2170	389	4	09:00:00	18:00:00	2026-10-25	\N	t
2171	389	5	09:00:00	18:00:00	2026-10-25	\N	t
2172	389	6	09:00:00	18:00:00	2026-10-25	\N	t
2173	390	1	06:00:00	22:00:00	2026-10-25	\N	t
2174	390	2	06:00:00	22:00:00	2026-10-25	\N	t
2175	390	3	06:00:00	22:00:00	2026-10-25	\N	t
2176	390	4	06:00:00	22:00:00	2026-10-25	\N	t
2177	390	5	06:00:00	22:00:00	2026-10-25	\N	t
2178	391	1	09:00:00	18:00:00	2026-10-25	\N	t
2179	391	2	09:00:00	18:00:00	2026-10-25	\N	t
2180	391	3	09:00:00	18:00:00	2026-10-25	\N	t
2181	391	4	09:00:00	18:00:00	2026-10-25	\N	t
2182	391	5	09:00:00	18:00:00	2026-10-25	\N	t
2183	391	6	09:00:00	18:00:00	2026-10-25	\N	t
2184	392	1	06:00:00	22:00:00	2026-10-25	\N	t
2185	392	2	06:00:00	22:00:00	2026-10-25	\N	t
2186	392	3	06:00:00	22:00:00	2026-10-25	\N	t
2187	392	4	06:00:00	22:00:00	2026-10-25	\N	t
2188	392	5	06:00:00	22:00:00	2026-10-25	\N	t
2189	393	1	09:00:00	18:00:00	2026-10-25	\N	t
2190	393	2	09:00:00	18:00:00	2026-10-25	\N	t
2191	393	3	09:00:00	18:00:00	2026-10-25	\N	t
2192	393	4	09:00:00	18:00:00	2026-10-25	\N	t
2193	393	5	09:00:00	18:00:00	2026-10-25	\N	t
2194	393	6	09:00:00	18:00:00	2026-10-25	\N	t
2195	394	1	09:00:00	18:00:00	2026-10-25	\N	t
2196	394	2	09:00:00	18:00:00	2026-10-25	\N	t
2197	394	3	09:00:00	18:00:00	2026-10-25	\N	t
2198	394	4	09:00:00	18:00:00	2026-10-25	\N	t
2199	394	5	09:00:00	18:00:00	2026-10-25	\N	t
2200	394	6	09:00:00	18:00:00	2026-10-25	\N	t
2201	395	1	06:00:00	22:00:00	2026-10-25	\N	t
2202	395	2	06:00:00	22:00:00	2026-10-25	\N	t
2203	395	3	06:00:00	22:00:00	2026-10-25	\N	t
2204	395	4	06:00:00	22:00:00	2026-10-25	\N	t
2205	395	5	06:00:00	22:00:00	2026-10-25	\N	t
2206	396	1	09:00:00	18:00:00	2026-10-25	\N	t
2207	396	2	09:00:00	18:00:00	2026-10-25	\N	t
2208	396	3	09:00:00	18:00:00	2026-10-25	\N	t
2209	396	4	09:00:00	18:00:00	2026-10-25	\N	t
2210	396	5	09:00:00	18:00:00	2026-10-25	\N	t
2211	396	6	09:00:00	18:00:00	2026-10-25	\N	t
2212	397	1	09:00:00	18:00:00	2026-10-25	\N	t
2213	397	2	09:00:00	18:00:00	2026-10-25	\N	t
2214	397	3	09:00:00	18:00:00	2026-10-25	\N	t
2215	397	4	09:00:00	18:00:00	2026-10-25	\N	t
2216	397	5	09:00:00	18:00:00	2026-10-25	\N	t
2217	397	6	09:00:00	18:00:00	2026-10-25	\N	t
2218	398	1	06:00:00	22:00:00	2026-10-25	\N	t
2219	398	2	06:00:00	22:00:00	2026-10-25	\N	t
2220	398	3	06:00:00	22:00:00	2026-10-25	\N	t
2221	398	4	06:00:00	22:00:00	2026-10-25	\N	t
2222	398	5	06:00:00	22:00:00	2026-10-25	\N	t
2223	399	1	09:00:00	18:00:00	2026-10-25	\N	t
2224	399	2	09:00:00	18:00:00	2026-10-25	\N	t
2225	399	3	09:00:00	18:00:00	2026-10-25	\N	t
2226	399	4	09:00:00	18:00:00	2026-10-25	\N	t
2227	399	5	09:00:00	18:00:00	2026-10-25	\N	t
2228	399	6	09:00:00	18:00:00	2026-10-25	\N	t
2229	400	1	06:00:00	22:00:00	2026-10-25	\N	t
2230	400	2	06:00:00	22:00:00	2026-10-25	\N	t
2231	400	3	06:00:00	22:00:00	2026-10-25	\N	t
2232	400	4	06:00:00	22:00:00	2026-10-25	\N	t
2233	400	5	06:00:00	22:00:00	2026-10-25	\N	t
2234	401	1	09:00:00	18:00:00	2026-10-25	\N	t
2235	401	2	09:00:00	18:00:00	2026-10-25	\N	t
2236	401	3	09:00:00	18:00:00	2026-10-25	\N	t
2237	401	4	09:00:00	18:00:00	2026-10-25	\N	t
2238	401	5	09:00:00	18:00:00	2026-10-25	\N	t
2239	401	6	09:00:00	18:00:00	2026-10-25	\N	t
2240	402	1	06:00:00	22:00:00	2026-10-25	\N	t
2241	402	2	06:00:00	22:00:00	2026-10-25	\N	t
2242	402	3	06:00:00	22:00:00	2026-10-25	\N	t
2243	402	4	06:00:00	22:00:00	2026-10-25	\N	t
2244	402	5	06:00:00	22:00:00	2026-10-25	\N	t
2245	403	1	09:00:00	18:00:00	2026-10-25	\N	t
2246	403	2	09:00:00	18:00:00	2026-10-25	\N	t
2247	403	3	09:00:00	18:00:00	2026-10-25	\N	t
2248	403	4	09:00:00	18:00:00	2026-10-25	\N	t
2249	403	5	09:00:00	18:00:00	2026-10-25	\N	t
2250	403	6	09:00:00	18:00:00	2026-10-25	\N	t
2251	404	1	06:00:00	22:00:00	2026-10-25	\N	t
2252	404	2	06:00:00	22:00:00	2026-10-25	\N	t
2253	404	3	06:00:00	22:00:00	2026-10-25	\N	t
2254	404	4	06:00:00	22:00:00	2026-10-25	\N	t
2255	404	5	06:00:00	22:00:00	2026-10-25	\N	t
2256	405	1	09:00:00	18:00:00	2026-10-25	\N	t
2257	405	2	09:00:00	18:00:00	2026-10-25	\N	t
2258	405	3	09:00:00	18:00:00	2026-10-25	\N	t
2259	405	4	09:00:00	18:00:00	2026-10-25	\N	t
2260	405	5	09:00:00	18:00:00	2026-10-25	\N	t
2261	405	6	09:00:00	18:00:00	2026-10-25	\N	t
2262	406	1	06:00:00	22:00:00	2026-10-25	\N	t
2263	406	2	06:00:00	22:00:00	2026-10-25	\N	t
2264	406	3	06:00:00	22:00:00	2026-10-25	\N	t
2265	406	4	06:00:00	22:00:00	2026-10-25	\N	t
2266	406	5	06:00:00	22:00:00	2026-10-25	\N	t
2267	407	1	09:00:00	18:00:00	2026-10-25	\N	t
2268	407	2	09:00:00	18:00:00	2026-10-25	\N	t
2269	407	3	09:00:00	18:00:00	2026-10-25	\N	t
2270	407	4	09:00:00	18:00:00	2026-10-25	\N	t
2271	407	5	09:00:00	18:00:00	2026-10-25	\N	t
2272	407	6	09:00:00	18:00:00	2026-10-25	\N	t
2273	408	1	06:00:00	22:00:00	2026-10-25	\N	t
2274	408	2	06:00:00	22:00:00	2026-10-25	\N	t
2275	408	3	06:00:00	22:00:00	2026-10-25	\N	t
2276	408	4	06:00:00	22:00:00	2026-10-25	\N	t
2277	408	5	06:00:00	22:00:00	2026-10-25	\N	t
2278	409	1	09:00:00	18:00:00	2026-10-25	\N	t
2279	409	2	09:00:00	18:00:00	2026-10-25	\N	t
2280	409	3	09:00:00	18:00:00	2026-10-25	\N	t
2281	409	4	09:00:00	18:00:00	2026-10-25	\N	t
2282	409	5	09:00:00	18:00:00	2026-10-25	\N	t
2283	409	6	09:00:00	18:00:00	2026-10-25	\N	t
2284	410	1	06:00:00	22:00:00	2026-10-25	\N	t
2285	410	2	06:00:00	22:00:00	2026-10-25	\N	t
2286	410	3	06:00:00	22:00:00	2026-10-25	\N	t
2287	410	4	06:00:00	22:00:00	2026-10-25	\N	t
2288	410	5	06:00:00	22:00:00	2026-10-25	\N	t
2289	411	1	09:00:00	18:00:00	2026-10-25	\N	t
2290	411	2	09:00:00	18:00:00	2026-10-25	\N	t
2291	411	3	09:00:00	18:00:00	2026-10-25	\N	t
2292	411	4	09:00:00	18:00:00	2026-10-25	\N	t
2293	411	5	09:00:00	18:00:00	2026-10-25	\N	t
2294	411	6	09:00:00	18:00:00	2026-10-25	\N	t
2295	412	1	06:00:00	22:00:00	2026-10-25	\N	t
2296	412	2	06:00:00	22:00:00	2026-10-25	\N	t
2297	412	3	06:00:00	22:00:00	2026-10-25	\N	t
2298	412	4	06:00:00	22:00:00	2026-10-25	\N	t
2299	412	5	06:00:00	22:00:00	2026-10-25	\N	t
2300	413	1	09:00:00	18:00:00	2026-10-25	\N	t
2301	413	2	09:00:00	18:00:00	2026-10-25	\N	t
2302	413	3	09:00:00	18:00:00	2026-10-25	\N	t
2303	413	4	09:00:00	18:00:00	2026-10-25	\N	t
2304	413	5	09:00:00	18:00:00	2026-10-25	\N	t
2305	413	6	09:00:00	18:00:00	2026-10-25	\N	t
2306	414	1	06:00:00	22:00:00	2026-10-25	\N	t
2307	414	2	06:00:00	22:00:00	2026-10-25	\N	t
2308	414	3	06:00:00	22:00:00	2026-10-25	\N	t
2309	414	4	06:00:00	22:00:00	2026-10-25	\N	t
2310	414	5	06:00:00	22:00:00	2026-10-25	\N	t
2311	415	1	09:00:00	18:00:00	2026-10-25	\N	t
2312	415	2	09:00:00	18:00:00	2026-10-25	\N	t
2313	415	3	09:00:00	18:00:00	2026-10-25	\N	t
2314	415	4	09:00:00	18:00:00	2026-10-25	\N	t
2315	415	5	09:00:00	18:00:00	2026-10-25	\N	t
2316	415	6	09:00:00	18:00:00	2026-10-25	\N	t
2317	416	1	06:00:00	22:00:00	2026-10-25	\N	t
2318	416	2	06:00:00	22:00:00	2026-10-25	\N	t
2319	416	3	06:00:00	22:00:00	2026-10-25	\N	t
2320	416	4	06:00:00	22:00:00	2026-10-25	\N	t
2321	416	5	06:00:00	22:00:00	2026-10-25	\N	t
2322	417	1	09:00:00	18:00:00	2026-10-25	\N	t
2323	417	2	09:00:00	18:00:00	2026-10-25	\N	t
2324	417	3	09:00:00	18:00:00	2026-10-25	\N	t
2325	417	4	09:00:00	18:00:00	2026-10-25	\N	t
2326	417	5	09:00:00	18:00:00	2026-10-25	\N	t
2327	417	6	09:00:00	18:00:00	2026-10-25	\N	t
2328	418	1	06:00:00	22:00:00	2026-10-25	\N	t
2329	418	2	06:00:00	22:00:00	2026-10-25	\N	t
2330	418	3	06:00:00	22:00:00	2026-10-25	\N	t
2331	418	4	06:00:00	22:00:00	2026-10-25	\N	t
2332	418	5	06:00:00	22:00:00	2026-10-25	\N	t
2333	419	1	09:00:00	18:00:00	2026-10-25	\N	t
2334	419	2	09:00:00	18:00:00	2026-10-25	\N	t
2335	419	3	09:00:00	18:00:00	2026-10-25	\N	t
2336	419	4	09:00:00	18:00:00	2026-10-25	\N	t
2337	419	5	09:00:00	18:00:00	2026-10-25	\N	t
2338	419	6	09:00:00	18:00:00	2026-10-25	\N	t
2339	420	1	06:00:00	22:00:00	2026-10-25	\N	t
2340	420	2	06:00:00	22:00:00	2026-10-25	\N	t
2341	420	3	06:00:00	22:00:00	2026-10-25	\N	t
2342	420	4	06:00:00	22:00:00	2026-10-25	\N	t
2343	420	5	06:00:00	22:00:00	2026-10-25	\N	t
2344	421	1	09:00:00	18:00:00	2026-10-25	\N	t
2345	421	2	09:00:00	18:00:00	2026-10-25	\N	t
2346	421	3	09:00:00	18:00:00	2026-10-25	\N	t
2347	421	4	09:00:00	18:00:00	2026-10-25	\N	t
2348	421	5	09:00:00	18:00:00	2026-10-25	\N	t
2349	421	6	09:00:00	18:00:00	2026-10-25	\N	t
2350	422	1	06:00:00	22:00:00	2026-10-25	\N	t
2351	422	2	06:00:00	22:00:00	2026-10-25	\N	t
2352	422	3	06:00:00	22:00:00	2026-10-25	\N	t
2353	422	4	06:00:00	22:00:00	2026-10-25	\N	t
2354	422	5	06:00:00	22:00:00	2026-10-25	\N	t
2355	423	1	09:00:00	18:00:00	2026-10-25	\N	t
2356	423	2	09:00:00	18:00:00	2026-10-25	\N	t
2357	423	3	09:00:00	18:00:00	2026-10-25	\N	t
2358	423	4	09:00:00	18:00:00	2026-10-25	\N	t
2359	423	5	09:00:00	18:00:00	2026-10-25	\N	t
2360	423	6	09:00:00	18:00:00	2026-10-25	\N	t
2361	424	1	06:00:00	22:00:00	2026-10-25	\N	t
2362	424	2	06:00:00	22:00:00	2026-10-25	\N	t
2363	424	3	06:00:00	22:00:00	2026-10-25	\N	t
2364	424	4	06:00:00	22:00:00	2026-10-25	\N	t
2365	424	5	06:00:00	22:00:00	2026-10-25	\N	t
2366	425	1	09:00:00	18:00:00	2026-10-25	\N	t
2367	425	2	09:00:00	18:00:00	2026-10-25	\N	t
2368	425	3	09:00:00	18:00:00	2026-10-25	\N	t
2369	425	4	09:00:00	18:00:00	2026-10-25	\N	t
2370	425	5	09:00:00	18:00:00	2026-10-25	\N	t
2371	425	6	09:00:00	18:00:00	2026-10-25	\N	t
2372	426	1	06:00:00	22:00:00	2026-10-25	\N	t
2373	426	2	06:00:00	22:00:00	2026-10-25	\N	t
2374	426	3	06:00:00	22:00:00	2026-10-25	\N	t
2375	426	4	06:00:00	22:00:00	2026-10-25	\N	t
2376	426	5	06:00:00	22:00:00	2026-10-25	\N	t
2377	427	1	09:00:00	18:00:00	2026-10-25	\N	t
2378	427	2	09:00:00	18:00:00	2026-10-25	\N	t
2379	427	3	09:00:00	18:00:00	2026-10-25	\N	t
2380	427	4	09:00:00	18:00:00	2026-10-25	\N	t
2381	427	5	09:00:00	18:00:00	2026-10-25	\N	t
2382	427	6	09:00:00	18:00:00	2026-10-25	\N	t
2383	428	1	06:00:00	22:00:00	2026-10-25	\N	t
2384	428	2	06:00:00	22:00:00	2026-10-25	\N	t
2385	428	3	06:00:00	22:00:00	2026-10-25	\N	t
2386	428	4	06:00:00	22:00:00	2026-10-25	\N	t
2387	428	5	06:00:00	22:00:00	2026-10-25	\N	t
2388	429	1	09:00:00	18:00:00	2026-10-25	\N	t
2389	429	2	09:00:00	18:00:00	2026-10-25	\N	t
2390	429	3	09:00:00	18:00:00	2026-10-25	\N	t
2391	429	4	09:00:00	18:00:00	2026-10-25	\N	t
2392	429	5	09:00:00	18:00:00	2026-10-25	\N	t
2393	429	6	09:00:00	18:00:00	2026-10-25	\N	t
2394	430	1	06:00:00	22:00:00	2026-10-25	\N	t
2395	430	2	06:00:00	22:00:00	2026-10-25	\N	t
2396	430	3	06:00:00	22:00:00	2026-10-25	\N	t
2397	430	4	06:00:00	22:00:00	2026-10-25	\N	t
2398	430	5	06:00:00	22:00:00	2026-10-25	\N	t
2399	431	1	09:00:00	18:00:00	2026-10-25	\N	t
2400	431	2	09:00:00	18:00:00	2026-10-25	\N	t
2401	431	3	09:00:00	18:00:00	2026-10-25	\N	t
2402	431	4	09:00:00	18:00:00	2026-10-25	\N	t
2403	431	5	09:00:00	18:00:00	2026-10-25	\N	t
2404	431	6	09:00:00	18:00:00	2026-10-25	\N	t
2405	432	1	06:00:00	22:00:00	2026-10-25	\N	t
2406	432	2	06:00:00	22:00:00	2026-10-25	\N	t
2407	432	3	06:00:00	22:00:00	2026-10-25	\N	t
2408	432	4	06:00:00	22:00:00	2026-10-25	\N	t
2409	432	5	06:00:00	22:00:00	2026-10-25	\N	t
2410	433	1	09:00:00	18:00:00	2026-10-25	\N	t
2411	433	2	09:00:00	18:00:00	2026-10-25	\N	t
2412	433	3	09:00:00	18:00:00	2026-10-25	\N	t
2413	433	4	09:00:00	18:00:00	2026-10-25	\N	t
2414	433	5	09:00:00	18:00:00	2026-10-25	\N	t
2415	433	6	09:00:00	18:00:00	2026-10-25	\N	t
2416	434	1	06:00:00	22:00:00	2026-10-25	\N	t
2417	434	2	06:00:00	22:00:00	2026-10-25	\N	t
2418	434	3	06:00:00	22:00:00	2026-10-25	\N	t
2419	434	4	06:00:00	22:00:00	2026-10-25	\N	t
2420	434	5	06:00:00	22:00:00	2026-10-25	\N	t
2421	435	1	09:00:00	18:00:00	2026-10-25	\N	t
2422	435	2	09:00:00	18:00:00	2026-10-25	\N	t
2423	435	3	09:00:00	18:00:00	2026-10-25	\N	t
2424	435	4	09:00:00	18:00:00	2026-10-25	\N	t
2425	435	5	09:00:00	18:00:00	2026-10-25	\N	t
2426	435	6	09:00:00	18:00:00	2026-10-25	\N	t
2427	436	1	06:00:00	22:00:00	2026-10-25	\N	t
2428	436	2	06:00:00	22:00:00	2026-10-25	\N	t
2429	436	3	06:00:00	22:00:00	2026-10-25	\N	t
2430	436	4	06:00:00	22:00:00	2026-10-25	\N	t
2431	436	5	06:00:00	22:00:00	2026-10-25	\N	t
2432	437	1	09:00:00	18:00:00	2026-10-25	\N	t
2433	437	2	09:00:00	18:00:00	2026-10-25	\N	t
2434	437	3	09:00:00	18:00:00	2026-10-25	\N	t
2435	437	4	09:00:00	18:00:00	2026-10-25	\N	t
2436	437	5	09:00:00	18:00:00	2026-10-25	\N	t
2437	437	6	09:00:00	18:00:00	2026-10-25	\N	t
2438	438	1	06:00:00	22:00:00	2026-10-25	\N	t
2439	438	2	06:00:00	22:00:00	2026-10-25	\N	t
2440	438	3	06:00:00	22:00:00	2026-10-25	\N	t
2441	438	4	06:00:00	22:00:00	2026-10-25	\N	t
2442	438	5	06:00:00	22:00:00	2026-10-25	\N	t
2443	439	1	09:00:00	18:00:00	2026-10-25	\N	t
2444	439	2	09:00:00	18:00:00	2026-10-25	\N	t
2445	439	3	09:00:00	18:00:00	2026-10-25	\N	t
2446	439	4	09:00:00	18:00:00	2026-10-25	\N	t
2447	439	5	09:00:00	18:00:00	2026-10-25	\N	t
2448	439	6	09:00:00	18:00:00	2026-10-25	\N	t
2449	440	1	06:00:00	22:00:00	2026-10-25	\N	t
2450	440	2	06:00:00	22:00:00	2026-10-25	\N	t
2451	440	3	06:00:00	22:00:00	2026-10-25	\N	t
2452	440	4	06:00:00	22:00:00	2026-10-25	\N	t
2453	440	5	06:00:00	22:00:00	2026-10-25	\N	t
2454	441	1	09:00:00	18:00:00	2026-11-25	\N	t
2455	441	2	09:00:00	18:00:00	2026-11-25	\N	t
2456	441	3	09:00:00	18:00:00	2026-11-25	\N	t
2457	441	4	09:00:00	18:00:00	2026-11-25	\N	t
2458	441	5	09:00:00	18:00:00	2026-11-25	\N	t
2459	441	6	09:00:00	18:00:00	2026-11-25	\N	t
\.


--
-- Data for Name: machine_maintenance_blocks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.machine_maintenance_blocks (id, machine_id, start_at, end_at, reason, created_at) FROM stdin;
1	1	2026-11-30 09:00:00+00	2026-11-30 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
2	4	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
3	5	2026-12-01 09:00:00+00	2026-12-01 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
4	8	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
5	10	2026-12-02 09:00:00+00	2026-12-02 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
6	13	2026-12-03 09:00:00+00	2026-12-03 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
7	16	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
8	17	2026-12-04 09:00:00+00	2026-12-04 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
9	20	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
10	22	2026-12-05 09:00:00+00	2026-12-05 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
11	25	2026-12-06 09:00:00+00	2026-12-06 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
12	28	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
13	29	2026-12-07 09:00:00+00	2026-12-07 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
14	32	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
15	34	2026-12-08 09:00:00+00	2026-12-08 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
16	37	2026-12-09 09:00:00+00	2026-12-09 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
17	40	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
18	41	2026-12-10 09:00:00+00	2026-12-10 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
19	44	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
20	46	2026-12-11 09:00:00+00	2026-12-11 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
21	49	2026-12-12 09:00:00+00	2026-12-12 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
22	52	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
23	53	2026-12-13 09:00:00+00	2026-12-13 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
24	56	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
25	58	2026-12-14 09:00:00+00	2026-12-14 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
26	61	2026-12-15 09:00:00+00	2026-12-15 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
27	64	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
28	65	2026-12-16 09:00:00+00	2026-12-16 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
29	68	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
30	70	2026-12-17 09:00:00+00	2026-12-17 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
31	73	2026-12-18 09:00:00+00	2026-12-18 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
32	76	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
33	77	2026-11-29 09:00:00+00	2026-11-29 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
34	80	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
35	82	2026-11-30 09:00:00+00	2026-11-30 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
36	85	2026-12-01 09:00:00+00	2026-12-01 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
37	88	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
38	89	2026-12-02 09:00:00+00	2026-12-02 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
39	92	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
40	94	2026-12-03 09:00:00+00	2026-12-03 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
41	97	2026-12-04 09:00:00+00	2026-12-04 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
42	100	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
43	101	2026-12-05 09:00:00+00	2026-12-05 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
44	104	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
45	106	2026-12-06 09:00:00+00	2026-12-06 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
46	109	2026-12-07 09:00:00+00	2026-12-07 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
47	112	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
48	113	2026-12-08 09:00:00+00	2026-12-08 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
49	116	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
50	118	2026-12-09 09:00:00+00	2026-12-09 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
51	121	2026-12-10 09:00:00+00	2026-12-10 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
52	124	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
53	125	2026-12-11 09:00:00+00	2026-12-11 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
54	128	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
55	130	2026-12-12 09:00:00+00	2026-12-12 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
56	133	2026-12-13 09:00:00+00	2026-12-13 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
57	136	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
58	137	2026-12-14 09:00:00+00	2026-12-14 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
59	140	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
60	142	2026-12-15 09:00:00+00	2026-12-15 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
61	145	2026-12-16 09:00:00+00	2026-12-16 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
62	148	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
63	149	2026-12-17 09:00:00+00	2026-12-17 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
64	152	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
65	154	2026-12-18 09:00:00+00	2026-12-18 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
66	157	2026-11-29 09:00:00+00	2026-11-29 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
67	160	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
68	161	2026-11-30 09:00:00+00	2026-11-30 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
69	164	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
70	166	2026-12-01 09:00:00+00	2026-12-01 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
71	169	2026-12-02 09:00:00+00	2026-12-02 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
72	172	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
73	173	2026-12-03 09:00:00+00	2026-12-03 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
74	176	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
75	178	2026-12-04 09:00:00+00	2026-12-04 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
76	181	2026-12-05 09:00:00+00	2026-12-05 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
77	184	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
78	185	2026-12-06 09:00:00+00	2026-12-06 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
79	188	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
80	190	2026-12-07 09:00:00+00	2026-12-07 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
81	193	2026-12-08 09:00:00+00	2026-12-08 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
82	196	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
83	197	2026-12-09 09:00:00+00	2026-12-09 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
84	200	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
85	202	2026-12-10 09:00:00+00	2026-12-10 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
86	205	2026-12-11 09:00:00+00	2026-12-11 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
87	208	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
88	209	2026-12-12 09:00:00+00	2026-12-12 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
89	212	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
90	214	2026-12-13 09:00:00+00	2026-12-13 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
91	217	2026-12-14 09:00:00+00	2026-12-14 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
92	220	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
93	221	2026-12-15 09:00:00+00	2026-12-15 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
94	224	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
95	226	2026-12-16 09:00:00+00	2026-12-16 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
96	229	2026-12-17 09:00:00+00	2026-12-17 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
97	232	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
98	233	2026-12-18 09:00:00+00	2026-12-18 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
99	236	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
100	238	2026-11-29 09:00:00+00	2026-11-29 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
101	241	2026-11-30 09:00:00+00	2026-11-30 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
102	244	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
103	245	2026-12-01 09:00:00+00	2026-12-01 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
104	248	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
105	250	2026-12-02 09:00:00+00	2026-12-02 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
106	253	2026-12-03 09:00:00+00	2026-12-03 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
107	256	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
108	257	2026-12-04 09:00:00+00	2026-12-04 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
109	260	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
110	262	2026-12-05 09:00:00+00	2026-12-05 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
111	265	2026-12-06 09:00:00+00	2026-12-06 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
112	268	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
113	269	2026-12-07 09:00:00+00	2026-12-07 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
114	272	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
115	274	2026-12-08 09:00:00+00	2026-12-08 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
116	277	2026-12-09 09:00:00+00	2026-12-09 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
117	280	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
118	281	2026-12-10 09:00:00+00	2026-12-10 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
119	284	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
120	286	2026-12-11 09:00:00+00	2026-12-11 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
121	289	2026-12-12 09:00:00+00	2026-12-12 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
122	292	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
123	293	2026-12-13 09:00:00+00	2026-12-13 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
124	296	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
125	298	2026-12-14 09:00:00+00	2026-12-14 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
126	301	2026-12-15 09:00:00+00	2026-12-15 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
127	304	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
128	305	2026-12-16 09:00:00+00	2026-12-16 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
129	308	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
130	310	2026-12-17 09:00:00+00	2026-12-17 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
131	313	2026-12-18 09:00:00+00	2026-12-18 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
132	316	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
133	317	2026-11-29 09:00:00+00	2026-11-29 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
134	320	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
135	322	2026-11-30 09:00:00+00	2026-11-30 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
136	325	2026-12-01 09:00:00+00	2026-12-01 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
137	328	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
138	329	2026-12-02 09:00:00+00	2026-12-02 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
139	332	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
140	334	2026-12-03 09:00:00+00	2026-12-03 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
141	337	2026-12-04 09:00:00+00	2026-12-04 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
142	340	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
143	341	2026-12-05 09:00:00+00	2026-12-05 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
144	344	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
145	346	2026-12-06 09:00:00+00	2026-12-06 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
146	349	2026-12-07 09:00:00+00	2026-12-07 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
147	352	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
148	353	2026-12-08 09:00:00+00	2026-12-08 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
149	356	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
150	358	2026-12-09 09:00:00+00	2026-12-09 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
151	361	2026-12-10 09:00:00+00	2026-12-10 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
152	364	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
153	365	2026-12-11 09:00:00+00	2026-12-11 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
154	368	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
155	370	2026-12-12 09:00:00+00	2026-12-12 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
156	373	2026-12-13 09:00:00+00	2026-12-13 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
157	376	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
158	377	2026-12-14 09:00:00+00	2026-12-14 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
159	380	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
160	382	2026-12-15 09:00:00+00	2026-12-15 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
161	385	2026-12-16 09:00:00+00	2026-12-16 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
162	388	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
163	389	2026-12-17 09:00:00+00	2026-12-17 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
164	392	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
165	394	2026-12-18 09:00:00+00	2026-12-18 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
166	397	2026-11-29 09:00:00+00	2026-11-29 17:00:00+00	Quarterly preventive maintenance	2026-11-24 15:55:54.490593+00
167	400	2026-11-25 09:00:00+00	2026-11-27 18:00:00+00	Spindle bearing replacement and calibration	2026-11-24 15:55:54.490593+00
\.


--
-- Data for Name: machine_materials; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.machine_materials (machine_id, material_id) FROM stdin;
1	2
1	4
1	6
2	4
2	6
2	9
3	2
3	4
3	6
4	4
4	6
4	9
5	1
5	3
5	5
6	3
6	5
6	7
7	1
7	3
7	5
8	3
8	5
8	7
9	1
9	3
9	5
10	2
10	4
10	6
11	4
11	6
11	8
12	2
12	4
12	6
13	3
13	5
13	7
14	5
14	7
14	9
15	3
15	5
15	7
16	5
16	7
16	9
17	1
17	4
17	6
18	4
18	6
18	8
19	1
19	4
19	6
20	4
20	6
20	8
21	1
21	4
21	6
22	2
22	5
22	7
23	5
23	7
23	9
24	2
24	5
24	7
25	1
25	3
25	6
26	3
26	6
26	8
27	1
27	3
27	6
28	3
28	6
28	8
29	2
29	4
29	7
30	4
30	7
30	9
31	2
31	4
31	7
32	4
32	7
32	9
33	2
33	4
33	7
34	1
34	3
34	5
35	3
35	5
35	8
36	1
36	3
36	5
37	2
37	4
37	6
38	4
38	6
38	9
39	2
39	4
39	6
40	4
40	6
40	9
41	1
41	3
41	5
42	3
42	5
42	7
43	1
43	3
43	5
44	3
44	5
44	7
45	1
45	3
45	5
46	2
46	4
46	6
47	4
47	6
47	8
48	2
48	4
48	6
49	3
49	5
49	7
50	5
50	7
50	9
51	3
51	5
51	7
52	5
52	7
52	9
53	1
53	4
53	6
54	4
54	6
54	8
55	1
55	4
55	6
56	4
56	6
56	8
57	1
57	4
57	6
58	2
58	5
58	7
59	5
59	7
59	9
60	2
60	5
60	7
61	1
61	3
61	6
62	3
62	6
62	8
63	1
63	3
63	6
64	3
64	6
64	8
65	2
65	4
65	7
66	4
66	7
66	9
67	2
67	4
67	7
68	4
68	7
68	9
69	2
69	4
69	7
70	1
70	3
70	5
71	3
71	5
71	8
72	1
72	3
72	5
73	2
73	4
73	6
74	4
74	6
74	9
75	2
75	4
75	6
76	4
76	6
76	9
77	1
77	3
77	5
78	3
78	5
78	7
79	1
79	3
79	5
80	3
80	5
80	7
81	1
81	3
81	5
82	2
82	4
82	6
83	4
83	6
83	8
84	2
84	4
84	6
85	3
85	5
85	7
86	5
86	7
86	9
87	3
87	5
87	7
88	5
88	7
88	9
89	1
89	4
89	6
90	4
90	6
90	8
91	1
91	4
91	6
92	4
92	6
92	8
93	1
93	4
93	6
94	2
94	5
94	7
95	5
95	7
95	9
96	2
96	5
96	7
97	1
97	3
97	6
98	3
98	6
98	8
99	1
99	3
99	6
100	3
100	6
100	8
101	2
101	4
101	7
102	4
102	7
102	9
103	2
103	4
103	7
104	4
104	7
104	9
105	2
105	4
105	7
106	1
106	3
106	5
107	3
107	5
107	8
108	1
108	3
108	5
109	2
109	4
109	6
110	4
110	6
110	9
111	2
111	4
111	6
112	4
112	6
112	9
113	1
113	3
113	5
114	3
114	5
114	7
115	1
115	3
115	5
116	3
116	5
116	7
117	1
117	3
117	5
118	2
118	4
118	6
119	4
119	6
119	8
120	2
120	4
120	6
121	3
121	5
121	7
122	5
122	7
122	9
123	3
123	5
123	7
124	5
124	7
124	9
125	1
125	4
125	6
126	4
126	6
126	8
127	1
127	4
127	6
128	4
128	6
128	8
129	1
129	4
129	6
130	2
130	5
130	7
131	5
131	7
131	9
132	2
132	5
132	7
133	1
133	3
133	6
134	3
134	6
134	8
135	1
135	3
135	6
136	3
136	6
136	8
137	2
137	4
137	7
138	4
138	7
138	9
139	2
139	4
139	7
140	4
140	7
140	9
141	2
141	4
141	7
142	1
142	3
142	5
143	3
143	5
143	8
144	1
144	3
144	5
145	2
145	4
145	6
146	4
146	6
146	9
147	2
147	4
147	6
148	4
148	6
148	9
149	1
149	3
149	5
150	3
150	5
150	7
151	1
151	3
151	5
152	3
152	5
152	7
153	1
153	3
153	5
154	2
154	4
154	6
155	4
155	6
155	8
156	2
156	4
156	6
157	3
157	5
157	7
158	5
158	7
158	9
159	3
159	5
159	7
160	5
160	7
160	9
161	1
161	4
161	6
162	4
162	6
162	8
163	1
163	4
163	6
164	4
164	6
164	8
165	1
165	4
165	6
166	2
166	5
166	7
167	5
167	7
167	9
168	2
168	5
168	7
169	1
169	3
169	6
170	3
170	6
170	8
171	1
171	3
171	6
172	3
172	6
172	8
173	2
173	4
173	7
174	4
174	7
174	9
175	2
175	4
175	7
176	4
176	7
176	9
177	2
177	4
177	7
178	1
178	3
178	5
179	3
179	5
179	8
180	1
180	3
180	5
181	2
181	4
181	6
182	4
182	6
182	9
183	2
183	4
183	6
184	4
184	6
184	9
185	1
185	3
185	5
186	3
186	5
186	7
187	1
187	3
187	5
188	3
188	5
188	7
189	1
189	3
189	5
190	2
190	4
190	6
191	4
191	6
191	8
192	2
192	4
192	6
193	3
193	5
193	7
194	5
194	7
194	9
195	3
195	5
195	7
196	5
196	7
196	9
197	1
197	4
197	6
198	4
198	6
198	8
199	1
199	4
199	6
200	4
200	6
200	8
201	1
201	4
201	6
202	2
202	5
202	7
203	5
203	7
203	9
204	2
204	5
204	7
205	1
205	3
205	6
206	3
206	6
206	8
207	1
207	3
207	6
208	3
208	6
208	8
209	2
209	4
209	7
210	4
210	7
210	9
211	2
211	4
211	7
212	4
212	7
212	9
213	2
213	4
213	7
214	1
214	3
214	5
215	3
215	5
215	8
216	1
216	3
216	5
217	2
217	4
217	6
218	4
218	6
218	9
219	2
219	4
219	6
220	4
220	6
220	9
221	1
221	3
221	5
222	3
222	5
222	7
223	1
223	3
223	5
224	3
224	5
224	7
225	1
225	3
225	5
226	2
226	4
226	6
227	4
227	6
227	8
228	2
228	4
228	6
229	3
229	5
229	7
230	5
230	7
230	9
231	3
231	5
231	7
232	5
232	7
232	9
233	1
233	4
233	6
234	4
234	6
234	8
235	1
235	4
235	6
236	4
236	6
236	8
237	1
237	4
237	6
238	2
238	5
238	7
239	5
239	7
239	9
240	2
240	5
240	7
241	1
241	3
241	6
242	3
242	6
242	8
243	1
243	3
243	6
244	3
244	6
244	8
245	2
245	4
245	7
246	4
246	7
246	9
247	2
247	4
247	7
248	4
248	7
248	9
249	2
249	4
249	7
250	1
250	3
250	5
251	3
251	5
251	8
252	1
252	3
252	5
253	2
253	4
253	6
254	4
254	6
254	9
255	2
255	4
255	6
256	4
256	6
256	9
257	1
257	3
257	5
258	3
258	5
258	7
259	1
259	3
259	5
260	3
260	5
260	7
261	1
261	3
261	5
262	2
262	4
262	6
263	4
263	6
263	8
264	2
264	4
264	6
265	3
265	5
265	7
266	5
266	7
266	9
267	3
267	5
267	7
268	5
268	7
268	9
269	1
269	4
269	6
270	4
270	6
270	8
271	1
271	4
271	6
272	4
272	6
272	8
273	1
273	4
273	6
274	2
274	5
274	7
275	5
275	7
275	9
276	2
276	5
276	7
277	1
277	3
277	6
278	3
278	6
278	8
279	1
279	3
279	6
280	3
280	6
280	8
281	2
281	4
281	7
282	4
282	7
282	9
283	2
283	4
283	7
284	4
284	7
284	9
285	2
285	4
285	7
286	1
286	3
286	5
287	3
287	5
287	8
288	1
288	3
288	5
289	2
289	4
289	6
290	4
290	6
290	9
291	2
291	4
291	6
292	4
292	6
292	9
293	1
293	3
293	5
294	3
294	5
294	7
295	1
295	3
295	5
296	3
296	5
296	7
297	1
297	3
297	5
298	2
298	4
298	6
299	4
299	6
299	8
300	2
300	4
300	6
301	3
301	5
301	7
302	5
302	7
302	9
303	3
303	5
303	7
304	5
304	7
304	9
305	1
305	4
305	6
306	4
306	6
306	8
307	1
307	4
307	6
308	4
308	6
308	8
309	1
309	4
309	6
310	2
310	5
310	7
311	5
311	7
311	9
312	2
312	5
312	7
313	1
313	3
313	6
314	3
314	6
314	8
315	1
315	3
315	6
316	3
316	6
316	8
317	2
317	4
317	7
318	4
318	7
318	9
319	2
319	4
319	7
320	4
320	7
320	9
321	2
321	4
321	7
322	1
322	3
322	5
323	3
323	5
323	8
324	1
324	3
324	5
325	2
325	4
325	6
326	4
326	6
326	9
327	2
327	4
327	6
328	4
328	6
328	9
329	1
329	3
329	5
330	3
330	5
330	7
331	1
331	3
331	5
332	3
332	5
332	7
333	1
333	3
333	5
334	2
334	4
334	6
335	4
335	6
335	8
336	2
336	4
336	6
337	3
337	5
337	7
338	5
338	7
338	9
339	3
339	5
339	7
340	5
340	7
340	9
341	1
341	4
341	6
342	4
342	6
342	8
343	1
343	4
343	6
344	4
344	6
344	8
345	1
345	4
345	6
346	2
346	5
346	7
347	5
347	7
347	9
348	2
348	5
348	7
349	1
349	3
349	6
350	3
350	6
350	8
351	1
351	3
351	6
352	3
352	6
352	8
353	2
353	4
353	7
354	4
354	7
354	9
355	2
355	4
355	7
356	4
356	7
356	9
357	2
357	4
357	7
358	1
358	3
358	5
359	3
359	5
359	8
360	1
360	3
360	5
361	2
361	4
361	6
362	4
362	6
362	9
363	2
363	4
363	6
364	4
364	6
364	9
365	1
365	3
365	5
366	3
366	5
366	7
367	1
367	3
367	5
368	3
368	5
368	7
369	1
369	3
369	5
370	2
370	4
370	6
371	4
371	6
371	8
372	2
372	4
372	6
373	3
373	5
373	7
374	5
374	7
374	9
375	3
375	5
375	7
376	5
376	7
376	9
377	1
377	4
377	6
378	4
378	6
378	8
379	1
379	4
379	6
380	4
380	6
380	8
381	1
381	4
381	6
382	2
382	5
382	7
383	5
383	7
383	9
384	2
384	5
384	7
385	1
385	3
385	6
386	3
386	6
386	8
387	1
387	3
387	6
388	3
388	6
388	8
389	2
389	4
389	7
390	4
390	7
390	9
391	2
391	4
391	7
392	4
392	7
392	9
393	2
393	4
393	7
394	1
394	3
394	5
395	3
395	5
395	8
396	1
396	3
396	5
397	2
397	4
397	6
398	4
398	6
398	9
399	2
399	4
399	6
400	4
400	6
400	9
401	1
401	3
401	5
402	3
402	5
402	7
403	2
403	4
403	6
404	4
404	6
404	8
405	3
405	5
405	7
406	5
406	7
406	9
407	1
407	4
407	6
408	4
408	6
408	8
409	2
409	5
409	7
410	5
410	7
410	9
411	1
411	3
411	6
412	3
412	6
412	8
413	2
413	4
413	7
414	4
414	7
414	9
415	1
415	3
415	5
416	3
416	5
416	8
417	2
417	4
417	6
418	4
418	6
418	9
419	1
419	3
419	5
420	3
420	5
420	7
421	2
421	4
421	6
422	4
422	6
422	8
423	3
423	5
423	7
424	5
424	7
424	9
425	1
425	4
425	6
426	4
426	6
426	8
427	2
427	5
427	7
428	5
428	7
428	9
429	1
429	3
429	6
430	3
430	6
430	8
431	2
431	4
431	7
432	4
432	7
432	9
433	1
433	3
433	5
434	3
434	5
434	8
435	2
435	4
435	6
436	4
436	6
436	9
437	1
437	3
437	5
438	3
438	5
438	7
439	2
439	4
439	6
440	4
440	6
440	8
441	1
\.


--
-- Data for Name: machine_processes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.machine_processes (machine_id, process_id) FROM stdin;
1	2
1	5
2	5
2	7
3	2
3	5
4	5
4	7
5	3
5	6
6	6
6	8
7	3
7	6
8	6
8	8
9	3
9	6
10	1
10	4
11	4
11	7
12	1
12	4
13	2
13	5
14	5
14	8
15	2
15	5
16	5
16	8
17	1
17	3
18	3
18	6
19	1
19	3
20	3
20	6
21	1
21	3
22	2
22	4
23	4
23	7
24	2
24	4
25	3
25	5
26	5
26	8
27	3
27	5
28	5
28	8
29	1
29	4
30	4
30	6
31	1
31	4
32	4
32	6
33	1
33	4
34	2
34	5
35	5
35	7
36	2
36	5
37	3
37	6
38	6
38	8
39	3
39	6
40	6
40	8
41	1
41	4
42	4
42	7
43	1
43	4
44	4
44	7
45	1
45	4
46	2
46	5
47	5
47	8
48	2
48	5
49	1
49	3
50	3
50	6
51	1
51	3
52	3
52	6
53	2
53	4
54	4
54	7
55	2
55	4
56	4
56	7
57	2
57	4
58	3
58	5
59	5
59	8
60	3
60	5
61	1
61	4
62	4
62	6
63	1
63	4
64	4
64	6
65	2
65	5
66	5
66	7
67	2
67	5
68	5
68	7
69	2
69	5
70	3
70	6
71	6
71	8
72	3
72	6
73	1
73	4
74	4
74	7
75	1
75	4
76	4
76	7
77	2
77	5
78	5
78	8
79	2
79	5
80	5
80	8
81	2
81	5
82	1
82	3
83	3
83	6
84	1
84	3
85	2
85	4
86	4
86	7
87	2
87	4
88	4
88	7
89	3
89	5
90	5
90	8
91	3
91	5
92	5
92	8
93	3
93	5
94	1
94	4
95	4
95	6
96	1
96	4
97	2
97	5
98	5
98	7
99	2
99	5
100	5
100	7
101	3
101	6
102	6
102	8
103	3
103	6
104	6
104	8
105	3
105	6
106	1
106	4
107	4
107	7
108	1
108	4
109	2
109	5
110	5
110	8
111	2
111	5
112	5
112	8
113	1
113	3
114	3
114	6
115	1
115	3
116	3
116	6
117	1
117	3
118	2
118	4
119	4
119	7
120	2
120	4
121	3
121	5
122	5
122	8
123	3
123	5
124	5
124	8
125	1
125	4
126	4
126	6
127	1
127	4
128	4
128	6
129	1
129	4
130	2
130	5
131	5
131	7
132	2
132	5
133	3
133	6
134	6
134	8
135	3
135	6
136	6
136	8
137	1
137	4
138	4
138	7
139	1
139	4
140	4
140	7
141	1
141	4
142	2
142	5
143	5
143	8
144	2
144	5
145	1
145	3
146	3
146	6
147	1
147	3
148	3
148	6
149	2
149	4
150	4
150	7
151	2
151	4
152	4
152	7
153	2
153	4
154	3
154	5
155	5
155	8
156	3
156	5
157	1
157	4
158	4
158	6
159	1
159	4
160	4
160	6
161	2
161	5
162	5
162	7
163	2
163	5
164	5
164	7
165	2
165	5
166	3
166	6
167	6
167	8
168	3
168	6
169	1
169	4
170	4
170	7
171	1
171	4
172	4
172	7
173	2
173	5
174	5
174	8
175	2
175	5
176	5
176	8
177	2
177	5
178	1
178	3
179	3
179	6
180	1
180	3
181	2
181	4
182	4
182	7
183	2
183	4
184	4
184	7
185	3
185	5
186	5
186	8
187	3
187	5
188	5
188	8
189	3
189	5
190	1
190	4
191	4
191	6
192	1
192	4
193	2
193	5
194	5
194	7
195	2
195	5
196	5
196	7
197	3
197	6
198	6
198	8
199	3
199	6
200	6
200	8
201	3
201	6
202	1
202	4
203	4
203	7
204	1
204	4
205	2
205	5
206	5
206	8
207	2
207	5
208	5
208	8
209	1
209	3
210	3
210	6
211	1
211	3
212	3
212	6
213	1
213	3
214	2
214	4
215	4
215	7
216	2
216	4
217	3
217	5
218	5
218	8
219	3
219	5
220	5
220	8
221	1
221	4
222	4
222	6
223	1
223	4
224	4
224	6
225	1
225	4
226	2
226	5
227	5
227	7
228	2
228	5
229	3
229	6
230	6
230	8
231	3
231	6
232	6
232	8
233	1
233	4
234	4
234	7
235	1
235	4
236	4
236	7
237	1
237	4
238	2
238	5
239	5
239	8
240	2
240	5
241	1
241	3
242	3
242	6
243	1
243	3
244	3
244	6
245	2
245	4
246	4
246	7
247	2
247	4
248	4
248	7
249	2
249	4
250	3
250	5
251	5
251	8
252	3
252	5
253	1
253	4
254	4
254	6
255	1
255	4
256	4
256	6
257	2
257	5
258	5
258	7
259	2
259	5
260	5
260	7
261	2
261	5
262	3
262	6
263	6
263	8
264	3
264	6
265	1
265	4
266	4
266	7
267	1
267	4
268	4
268	7
269	2
269	5
270	5
270	8
271	2
271	5
272	5
272	8
273	2
273	5
274	1
274	3
275	3
275	6
276	1
276	3
277	2
277	4
278	4
278	7
279	2
279	4
280	4
280	7
281	3
281	5
282	5
282	8
283	3
283	5
284	5
284	8
285	3
285	5
286	1
286	4
287	4
287	6
288	1
288	4
289	2
289	5
290	5
290	7
291	2
291	5
292	5
292	7
293	3
293	6
294	6
294	8
295	3
295	6
296	6
296	8
297	3
297	6
298	1
298	4
299	4
299	7
300	1
300	4
301	2
301	5
302	5
302	8
303	2
303	5
304	5
304	8
305	1
305	3
306	3
306	6
307	1
307	3
308	3
308	6
309	1
309	3
310	2
310	4
311	4
311	7
312	2
312	4
313	3
313	5
314	5
314	8
315	3
315	5
316	5
316	8
317	1
317	4
318	4
318	6
319	1
319	4
320	4
320	6
321	1
321	4
322	2
322	5
323	5
323	7
324	2
324	5
325	3
325	6
326	6
326	8
327	3
327	6
328	6
328	8
329	1
329	4
330	4
330	7
331	1
331	4
332	4
332	7
333	1
333	4
334	2
334	5
335	5
335	8
336	2
336	5
337	1
337	3
338	3
338	6
339	1
339	3
340	3
340	6
341	2
341	4
342	4
342	7
343	2
343	4
344	4
344	7
345	2
345	4
346	3
346	5
347	5
347	8
348	3
348	5
349	1
349	4
350	4
350	6
351	1
351	4
352	4
352	6
353	2
353	5
354	5
354	7
355	2
355	5
356	5
356	7
357	2
357	5
358	3
358	6
359	6
359	8
360	3
360	6
361	1
361	4
362	4
362	7
363	1
363	4
364	4
364	7
365	2
365	5
366	5
366	8
367	2
367	5
368	5
368	8
369	2
369	5
370	1
370	3
371	3
371	6
372	1
372	3
373	2
373	4
374	4
374	7
375	2
375	4
376	4
376	7
377	3
377	5
378	5
378	8
379	3
379	5
380	5
380	8
381	3
381	5
382	1
382	4
383	4
383	6
384	1
384	4
385	2
385	5
386	5
386	7
387	2
387	5
388	5
388	7
389	3
389	6
390	6
390	8
391	3
391	6
392	6
392	8
393	3
393	6
394	1
394	4
395	4
395	7
396	1
396	4
397	2
397	5
398	5
398	8
399	2
399	5
400	5
400	8
401	1
401	3
402	3
402	6
403	2
403	4
404	4
404	7
405	3
405	5
406	5
406	8
407	1
407	4
408	4
408	6
409	2
409	5
410	5
410	7
411	3
411	6
412	6
412	8
413	1
413	4
414	4
414	7
415	2
415	5
416	5
416	8
417	1
417	3
418	3
418	6
419	2
419	4
420	4
420	7
421	3
421	5
422	5
422	8
423	1
423	4
424	4
424	6
425	2
425	5
426	5
426	7
427	3
427	6
428	6
428	8
429	1
429	4
430	4
430	7
431	2
431	5
432	5
432	8
433	1
433	3
434	3
434	6
435	2
435	4
436	4
436	7
437	3
437	5
438	5
438	8
439	1
439	4
440	4
440	6
441	2
\.


--
-- Data for Name: machine_reservations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.machine_reservations (id, machine_id, production_order_id, start_at, end_at, status, reserved_by, created_at) FROM stdin;
\.


--
-- Data for Name: machines; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.machines (id, organization_id, machine_name, machine_type, model_number, serial_number, capacity_value, capacity_unit, machine_status, location, created_at, updated_at) FROM stdin;
1	3	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR001-00	850.00	mm X-travel	ACTIVE	Shop floor A, Vadodara	2026-11-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
2	3	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR001-01	250.00	mm swing	ACTIVE	Shop floor B, Vadodara	2026-11-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
3	3	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR001-02	500.00	mm pallet	ACTIVE	Shop floor C, Vadodara	2026-11-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
4	3	Fiber Laser Cutter 3 kW #4	Laser Cutting	FL-3015	SN-MFR001-03	3000.00	W	MAINTENANCE	Shop floor A, Vadodara	2026-11-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
5	4	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR002-00	500.00	kg/heat	ACTIVE	Shop floor A, Hyderabad	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
6	4	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR002-01	400.00	tonne	ACTIVE	Shop floor B, Hyderabad	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
7	4	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR002-02	180.00	tonne	ACTIVE	Shop floor C, Hyderabad	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
8	4	MIG Welding Robot Cell #4	Robotic Welding	RW-6A	SN-MFR002-03	6.00	axis	MAINTENANCE	Shop floor A, Hyderabad	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
9	4	Cylindrical Grinder CG-300 #5	Grinding	CG-300	SN-MFR002-04	300.00	mm length	ACTIVE	Shop floor B, Hyderabad	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
10	5	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR003-00	2000.00	kg	ACTIVE	Shop floor A, Indore	2026-11-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
11	5	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR003-01	400.00	mm X-travel	ACTIVE	Shop floor B, Indore	2026-11-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
12	5	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR003-02	2.00	m/min	ACTIVE	Shop floor C, Indore	2026-11-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
13	6	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR004-00	3000.00	W	ACTIVE	Shop floor A, Aurangabad	2026-11-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
14	6	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR004-01	100.00	tonne	ACTIVE	Shop floor B, Aurangabad	2026-11-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
15	6	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR004-02	250.00	tonne	ACTIVE	Shop floor C, Aurangabad	2026-11-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
16	6	Induction Furnace 500 kg #4	Melting Furnace	IF-500	SN-MFR004-03	500.00	kg/heat	MAINTENANCE	Shop floor A, Aurangabad	2026-11-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
17	7	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR005-00	180.00	tonne	ACTIVE	Shop floor A, Coimbatore	2026-11-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
18	7	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR005-01	6.00	axis	ACTIVE	Shop floor B, Coimbatore	2026-11-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
19	7	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR005-02	300.00	mm length	ACTIVE	Shop floor C, Coimbatore	2026-11-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
20	7	5-Axis Machining Centre #4	CNC 5-Axis	FA-5X400	SN-MFR005-03	400.00	mm table	MAINTENANCE	Shop floor A, Coimbatore	2026-11-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
21	7	Closed-Die Forging Hammer 2T #5	Forging Hammer	FH-2000	SN-MFR005-04	2000.00	kg	ACTIVE	Shop floor B, Coimbatore	2026-11-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
22	8	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR006-00	400.00	tonne	ACTIVE	Shop floor A, Faridabad	2026-11-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
23	8	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR006-01	180.00	tonne	ACTIVE	Shop floor B, Faridabad	2026-11-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
24	8	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR006-02	6.00	axis	ACTIVE	Shop floor C, Faridabad	2026-11-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
25	9	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR007-00	250.00	mm swing	ACTIVE	Shop floor A, Visakhapatnam	2026-11-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
26	9	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR007-01	500.00	mm pallet	ACTIVE	Shop floor B, Visakhapatnam	2026-11-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
27	9	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR007-02	3000.00	W	ACTIVE	Shop floor C, Visakhapatnam	2026-11-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
28	9	CNC Press Brake 100T #4	Press Brake	PB-100	SN-MFR007-03	100.00	tonne	MAINTENANCE	Shop floor A, Visakhapatnam	2026-11-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
29	10	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR008-00	300.00	mm length	ACTIVE	Shop floor A, Ahmedabad	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
30	10	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR008-01	400.00	mm table	ACTIVE	Shop floor B, Ahmedabad	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
31	10	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR008-02	2000.00	kg	ACTIVE	Shop floor C, Ahmedabad	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
32	10	Wire EDM W-400 #4	Wire EDM	WEDM-400	SN-MFR008-03	400.00	mm X-travel	MAINTENANCE	Shop floor A, Ahmedabad	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
33	10	Powder Coating Line #5	Surface Finishing	PCL-2	SN-MFR008-04	2.00	m/min	ACTIVE	Shop floor B, Ahmedabad	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
34	11	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR009-00	6.00	axis	ACTIVE	Shop floor A, Mysuru	2026-10-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
35	11	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR009-01	300.00	mm length	ACTIVE	Shop floor B, Mysuru	2026-10-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
36	11	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR009-02	400.00	mm table	ACTIVE	Shop floor C, Mysuru	2026-10-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
37	12	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR010-00	400.00	mm table	ACTIVE	Shop floor A, Jaipur	2026-10-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
38	12	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR010-01	2000.00	kg	ACTIVE	Shop floor B, Jaipur	2026-10-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
39	12	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR010-02	400.00	mm X-travel	ACTIVE	Shop floor C, Jaipur	2026-10-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
40	12	Powder Coating Line #4	Surface Finishing	PCL-2	SN-MFR010-03	2.00	m/min	MAINTENANCE	Shop floor A, Jaipur	2026-10-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
41	13	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR011-00	850.00	mm X-travel	ACTIVE	Shop floor A, Nashik	2026-10-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
42	13	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR011-01	250.00	mm swing	ACTIVE	Shop floor B, Nashik	2026-10-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
43	13	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR011-02	500.00	mm pallet	ACTIVE	Shop floor C, Nashik	2026-10-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
44	13	Fiber Laser Cutter 3 kW #4	Laser Cutting	FL-3015	SN-MFR011-03	3000.00	W	MAINTENANCE	Shop floor A, Nashik	2026-10-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
45	13	CNC Press Brake 100T #5	Press Brake	PB-100	SN-MFR011-04	100.00	tonne	ACTIVE	Shop floor B, Nashik	2026-10-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
46	14	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR012-00	500.00	kg/heat	ACTIVE	Shop floor A, Chennai	2026-10-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
47	14	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR012-01	400.00	tonne	ACTIVE	Shop floor B, Chennai	2026-10-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
48	14	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR012-02	180.00	tonne	ACTIVE	Shop floor C, Chennai	2026-10-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
49	15	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR013-00	2000.00	kg	ACTIVE	Shop floor A, Mohali	2026-10-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
50	15	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR013-01	400.00	mm X-travel	ACTIVE	Shop floor B, Mohali	2026-10-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
51	15	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR013-02	2.00	m/min	ACTIVE	Shop floor C, Mohali	2026-10-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
52	15	VMC-850 Vertical Machining Centre #4	CNC Vertical Machining Centre	VMC-850	SN-MFR013-03	850.00	mm X-travel	MAINTENANCE	Shop floor A, Mohali	2026-10-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
53	16	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR014-00	3000.00	W	ACTIVE	Shop floor A, Jamshedpur	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
54	16	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR014-01	100.00	tonne	ACTIVE	Shop floor B, Jamshedpur	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
55	16	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR014-02	250.00	tonne	ACTIVE	Shop floor C, Jamshedpur	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
56	16	Induction Furnace 500 kg #4	Melting Furnace	IF-500	SN-MFR014-03	500.00	kg/heat	MAINTENANCE	Shop floor A, Jamshedpur	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
57	16	Pressure Die Casting Machine 400T #5	Die Casting	PDC-400	SN-MFR014-04	400.00	tonne	ACTIVE	Shop floor B, Jamshedpur	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
58	17	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR015-00	180.00	tonne	ACTIVE	Shop floor A, Rajkot	2026-10-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
59	17	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR015-01	6.00	axis	ACTIVE	Shop floor B, Rajkot	2026-10-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
60	17	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR015-02	300.00	mm length	ACTIVE	Shop floor C, Rajkot	2026-10-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
61	18	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR016-00	400.00	tonne	ACTIVE	Shop floor A, Bengaluru	2026-10-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
62	18	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR016-01	180.00	tonne	ACTIVE	Shop floor B, Bengaluru	2026-10-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
63	18	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR016-02	6.00	axis	ACTIVE	Shop floor C, Bengaluru	2026-10-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
64	18	Cylindrical Grinder CG-300 #4	Grinding	CG-300	SN-MFR016-03	300.00	mm length	MAINTENANCE	Shop floor A, Bengaluru	2026-10-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
65	19	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR017-00	250.00	mm swing	ACTIVE	Shop floor A, Noida	2026-10-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
66	19	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR017-01	500.00	mm pallet	ACTIVE	Shop floor B, Noida	2026-10-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
67	19	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR017-02	3000.00	W	ACTIVE	Shop floor C, Noida	2026-10-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
68	19	CNC Press Brake 100T #4	Press Brake	PB-100	SN-MFR017-03	100.00	tonne	MAINTENANCE	Shop floor A, Noida	2026-10-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
69	19	Hydraulic Power Press 250T #5	Power Press	HP-250	SN-MFR017-04	250.00	tonne	ACTIVE	Shop floor B, Noida	2026-10-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
70	20	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR018-00	300.00	mm length	ACTIVE	Shop floor A, Mumbai	2026-10-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
71	20	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR018-01	400.00	mm table	ACTIVE	Shop floor B, Mumbai	2026-10-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
72	20	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR018-02	2000.00	kg	ACTIVE	Shop floor C, Mumbai	2026-10-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
73	21	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR019-00	6.00	axis	ACTIVE	Shop floor A, Surat	2026-09-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
74	21	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR019-01	300.00	mm length	ACTIVE	Shop floor B, Surat	2026-09-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
75	21	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR019-02	400.00	mm table	ACTIVE	Shop floor C, Surat	2026-09-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
76	21	Closed-Die Forging Hammer 2T #4	Forging Hammer	FH-2000	SN-MFR019-03	2000.00	kg	MAINTENANCE	Shop floor A, Surat	2026-09-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
77	22	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR020-00	400.00	mm table	ACTIVE	Shop floor A, Ludhiana	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
78	22	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR020-01	2000.00	kg	ACTIVE	Shop floor B, Ludhiana	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
79	22	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR020-02	400.00	mm X-travel	ACTIVE	Shop floor C, Ludhiana	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
80	22	Powder Coating Line #4	Surface Finishing	PCL-2	SN-MFR020-03	2.00	m/min	MAINTENANCE	Shop floor A, Ludhiana	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
81	22	VMC-850 Vertical Machining Centre #5	CNC Vertical Machining Centre	VMC-850	SN-MFR020-04	850.00	mm X-travel	ACTIVE	Shop floor B, Ludhiana	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
82	23	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR021-00	850.00	mm X-travel	ACTIVE	Shop floor A, Kolkata	2026-09-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
83	23	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR021-01	250.00	mm swing	ACTIVE	Shop floor B, Kolkata	2026-09-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
84	23	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR021-02	500.00	mm pallet	ACTIVE	Shop floor C, Kolkata	2026-09-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
85	24	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR022-00	500.00	kg/heat	ACTIVE	Shop floor A, Kolhapur	2026-09-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
86	24	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR022-01	400.00	tonne	ACTIVE	Shop floor B, Kolhapur	2026-09-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
87	24	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR022-02	180.00	tonne	ACTIVE	Shop floor C, Kolhapur	2026-09-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
88	24	MIG Welding Robot Cell #4	Robotic Welding	RW-6A	SN-MFR022-03	6.00	axis	MAINTENANCE	Shop floor A, Kolhapur	2026-09-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
89	25	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR023-00	2000.00	kg	ACTIVE	Shop floor A, Hosur	2026-09-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
90	25	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR023-01	400.00	mm X-travel	ACTIVE	Shop floor B, Hosur	2026-09-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
91	25	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR023-02	2.00	m/min	ACTIVE	Shop floor C, Hosur	2026-09-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
92	25	VMC-850 Vertical Machining Centre #4	CNC Vertical Machining Centre	VMC-850	SN-MFR023-03	850.00	mm X-travel	MAINTENANCE	Shop floor A, Hosur	2026-09-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
93	25	CNC Turning Centre TC-250 #5	CNC Lathe	TC-250	SN-MFR023-04	250.00	mm swing	ACTIVE	Shop floor B, Hosur	2026-09-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
94	26	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR024-00	3000.00	W	ACTIVE	Shop floor A, Gurugram	2026-09-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
95	26	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR024-01	100.00	tonne	ACTIVE	Shop floor B, Gurugram	2026-09-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
96	26	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR024-02	250.00	tonne	ACTIVE	Shop floor C, Gurugram	2026-09-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
97	27	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR025-00	180.00	tonne	ACTIVE	Shop floor A, Pune	2026-09-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
98	27	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR025-01	6.00	axis	ACTIVE	Shop floor B, Pune	2026-09-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
99	27	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR025-02	300.00	mm length	ACTIVE	Shop floor C, Pune	2026-09-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
100	27	5-Axis Machining Centre #4	CNC 5-Axis	FA-5X400	SN-MFR025-03	400.00	mm table	MAINTENANCE	Shop floor A, Pune	2026-09-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
101	28	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR026-00	400.00	tonne	ACTIVE	Shop floor A, Vadodara	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
102	28	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR026-01	180.00	tonne	ACTIVE	Shop floor B, Vadodara	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
103	28	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR026-02	6.00	axis	ACTIVE	Shop floor C, Vadodara	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
104	28	Cylindrical Grinder CG-300 #4	Grinding	CG-300	SN-MFR026-03	300.00	mm length	MAINTENANCE	Shop floor A, Vadodara	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
105	28	5-Axis Machining Centre #5	CNC 5-Axis	FA-5X400	SN-MFR026-04	400.00	mm table	ACTIVE	Shop floor B, Vadodara	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
106	29	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR027-00	250.00	mm swing	ACTIVE	Shop floor A, Hyderabad	2026-09-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
107	29	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR027-01	500.00	mm pallet	ACTIVE	Shop floor B, Hyderabad	2026-09-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
108	29	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR027-02	3000.00	W	ACTIVE	Shop floor C, Hyderabad	2026-09-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
109	30	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR028-00	300.00	mm length	ACTIVE	Shop floor A, Indore	2026-09-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
110	30	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR028-01	400.00	mm table	ACTIVE	Shop floor B, Indore	2026-09-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
111	30	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR028-02	2000.00	kg	ACTIVE	Shop floor C, Indore	2026-09-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
112	30	Wire EDM W-400 #4	Wire EDM	WEDM-400	SN-MFR028-03	400.00	mm X-travel	MAINTENANCE	Shop floor A, Indore	2026-09-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
113	31	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR029-00	6.00	axis	ACTIVE	Shop floor A, Aurangabad	2026-08-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
114	31	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR029-01	300.00	mm length	ACTIVE	Shop floor B, Aurangabad	2026-08-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
115	31	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR029-02	400.00	mm table	ACTIVE	Shop floor C, Aurangabad	2026-08-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
116	31	Closed-Die Forging Hammer 2T #4	Forging Hammer	FH-2000	SN-MFR029-03	2000.00	kg	MAINTENANCE	Shop floor A, Aurangabad	2026-08-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
117	31	Wire EDM W-400 #5	Wire EDM	WEDM-400	SN-MFR029-04	400.00	mm X-travel	ACTIVE	Shop floor B, Aurangabad	2026-08-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
118	32	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR030-00	400.00	mm table	ACTIVE	Shop floor A, Coimbatore	2026-08-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
119	32	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR030-01	2000.00	kg	ACTIVE	Shop floor B, Coimbatore	2026-08-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
120	32	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR030-02	400.00	mm X-travel	ACTIVE	Shop floor C, Coimbatore	2026-08-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
121	33	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR031-00	850.00	mm X-travel	ACTIVE	Shop floor A, Faridabad	2026-08-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
122	33	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR031-01	250.00	mm swing	ACTIVE	Shop floor B, Faridabad	2026-08-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
123	33	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR031-02	500.00	mm pallet	ACTIVE	Shop floor C, Faridabad	2026-08-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
124	33	Fiber Laser Cutter 3 kW #4	Laser Cutting	FL-3015	SN-MFR031-03	3000.00	W	MAINTENANCE	Shop floor A, Faridabad	2026-08-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
125	34	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR032-00	500.00	kg/heat	ACTIVE	Shop floor A, Visakhapatnam	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
126	34	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR032-01	400.00	tonne	ACTIVE	Shop floor B, Visakhapatnam	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
127	34	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR032-02	180.00	tonne	ACTIVE	Shop floor C, Visakhapatnam	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
128	34	MIG Welding Robot Cell #4	Robotic Welding	RW-6A	SN-MFR032-03	6.00	axis	MAINTENANCE	Shop floor A, Visakhapatnam	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
129	34	Cylindrical Grinder CG-300 #5	Grinding	CG-300	SN-MFR032-04	300.00	mm length	ACTIVE	Shop floor B, Visakhapatnam	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
130	35	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR033-00	2000.00	kg	ACTIVE	Shop floor A, Ahmedabad	2026-08-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
131	35	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR033-01	400.00	mm X-travel	ACTIVE	Shop floor B, Ahmedabad	2026-08-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
132	35	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR033-02	2.00	m/min	ACTIVE	Shop floor C, Ahmedabad	2026-08-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
133	36	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR034-00	3000.00	W	ACTIVE	Shop floor A, Mysuru	2026-08-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
134	36	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR034-01	100.00	tonne	ACTIVE	Shop floor B, Mysuru	2026-08-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
135	36	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR034-02	250.00	tonne	ACTIVE	Shop floor C, Mysuru	2026-08-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
136	36	Induction Furnace 500 kg #4	Melting Furnace	IF-500	SN-MFR034-03	500.00	kg/heat	MAINTENANCE	Shop floor A, Mysuru	2026-08-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
137	37	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR035-00	180.00	tonne	ACTIVE	Shop floor A, Jaipur	2026-08-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
138	37	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR035-01	6.00	axis	ACTIVE	Shop floor B, Jaipur	2026-08-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
139	37	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR035-02	300.00	mm length	ACTIVE	Shop floor C, Jaipur	2026-08-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
140	37	5-Axis Machining Centre #4	CNC 5-Axis	FA-5X400	SN-MFR035-03	400.00	mm table	MAINTENANCE	Shop floor A, Jaipur	2026-08-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
141	37	Closed-Die Forging Hammer 2T #5	Forging Hammer	FH-2000	SN-MFR035-04	2000.00	kg	ACTIVE	Shop floor B, Jaipur	2026-08-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
142	38	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR036-00	400.00	tonne	ACTIVE	Shop floor A, Nashik	2026-08-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
143	38	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR036-01	180.00	tonne	ACTIVE	Shop floor B, Nashik	2026-08-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
144	38	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR036-02	6.00	axis	ACTIVE	Shop floor C, Nashik	2026-08-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
145	39	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR037-00	250.00	mm swing	ACTIVE	Shop floor A, Chennai	2026-08-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
146	39	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR037-01	500.00	mm pallet	ACTIVE	Shop floor B, Chennai	2026-08-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
147	39	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR037-02	3000.00	W	ACTIVE	Shop floor C, Chennai	2026-08-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
148	39	CNC Press Brake 100T #4	Press Brake	PB-100	SN-MFR037-03	100.00	tonne	MAINTENANCE	Shop floor A, Chennai	2026-08-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
149	40	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR038-00	300.00	mm length	ACTIVE	Shop floor A, Mohali	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
150	40	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR038-01	400.00	mm table	ACTIVE	Shop floor B, Mohali	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
151	40	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR038-02	2000.00	kg	ACTIVE	Shop floor C, Mohali	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
152	40	Wire EDM W-400 #4	Wire EDM	WEDM-400	SN-MFR038-03	400.00	mm X-travel	MAINTENANCE	Shop floor A, Mohali	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
153	40	Powder Coating Line #5	Surface Finishing	PCL-2	SN-MFR038-04	2.00	m/min	ACTIVE	Shop floor B, Mohali	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
154	41	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR039-00	6.00	axis	ACTIVE	Shop floor A, Jamshedpur	2026-07-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
155	41	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR039-01	300.00	mm length	ACTIVE	Shop floor B, Jamshedpur	2026-07-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
156	41	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR039-02	400.00	mm table	ACTIVE	Shop floor C, Jamshedpur	2026-07-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
157	42	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR040-00	400.00	mm table	ACTIVE	Shop floor A, Rajkot	2026-07-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
158	42	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR040-01	2000.00	kg	ACTIVE	Shop floor B, Rajkot	2026-07-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
159	42	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR040-02	400.00	mm X-travel	ACTIVE	Shop floor C, Rajkot	2026-07-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
160	42	Powder Coating Line #4	Surface Finishing	PCL-2	SN-MFR040-03	2.00	m/min	MAINTENANCE	Shop floor A, Rajkot	2026-07-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
161	43	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR041-00	850.00	mm X-travel	ACTIVE	Shop floor A, Bengaluru	2026-07-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
162	43	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR041-01	250.00	mm swing	ACTIVE	Shop floor B, Bengaluru	2026-07-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
163	43	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR041-02	500.00	mm pallet	ACTIVE	Shop floor C, Bengaluru	2026-07-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
164	43	Fiber Laser Cutter 3 kW #4	Laser Cutting	FL-3015	SN-MFR041-03	3000.00	W	MAINTENANCE	Shop floor A, Bengaluru	2026-07-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
165	43	CNC Press Brake 100T #5	Press Brake	PB-100	SN-MFR041-04	100.00	tonne	ACTIVE	Shop floor B, Bengaluru	2026-07-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
166	44	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR042-00	500.00	kg/heat	ACTIVE	Shop floor A, Noida	2026-07-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
167	44	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR042-01	400.00	tonne	ACTIVE	Shop floor B, Noida	2026-07-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
168	44	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR042-02	180.00	tonne	ACTIVE	Shop floor C, Noida	2026-07-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
169	45	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR043-00	2000.00	kg	ACTIVE	Shop floor A, Mumbai	2026-07-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
170	45	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR043-01	400.00	mm X-travel	ACTIVE	Shop floor B, Mumbai	2026-07-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
171	45	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR043-02	2.00	m/min	ACTIVE	Shop floor C, Mumbai	2026-07-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
172	45	VMC-850 Vertical Machining Centre #4	CNC Vertical Machining Centre	VMC-850	SN-MFR043-03	850.00	mm X-travel	MAINTENANCE	Shop floor A, Mumbai	2026-07-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
173	46	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR044-00	3000.00	W	ACTIVE	Shop floor A, Surat	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
174	46	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR044-01	100.00	tonne	ACTIVE	Shop floor B, Surat	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
175	46	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR044-02	250.00	tonne	ACTIVE	Shop floor C, Surat	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
176	46	Induction Furnace 500 kg #4	Melting Furnace	IF-500	SN-MFR044-03	500.00	kg/heat	MAINTENANCE	Shop floor A, Surat	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
177	46	Pressure Die Casting Machine 400T #5	Die Casting	PDC-400	SN-MFR044-04	400.00	tonne	ACTIVE	Shop floor B, Surat	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
178	47	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR045-00	180.00	tonne	ACTIVE	Shop floor A, Ludhiana	2026-07-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
179	47	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR045-01	6.00	axis	ACTIVE	Shop floor B, Ludhiana	2026-07-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
180	47	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR045-02	300.00	mm length	ACTIVE	Shop floor C, Ludhiana	2026-07-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
181	48	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR046-00	400.00	tonne	ACTIVE	Shop floor A, Kolkata	2026-07-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
182	48	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR046-01	180.00	tonne	ACTIVE	Shop floor B, Kolkata	2026-07-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
183	48	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR046-02	6.00	axis	ACTIVE	Shop floor C, Kolkata	2026-07-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
184	48	Cylindrical Grinder CG-300 #4	Grinding	CG-300	SN-MFR046-03	300.00	mm length	MAINTENANCE	Shop floor A, Kolkata	2026-07-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
185	49	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR047-00	250.00	mm swing	ACTIVE	Shop floor A, Kolhapur	2026-07-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
186	49	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR047-01	500.00	mm pallet	ACTIVE	Shop floor B, Kolhapur	2026-07-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
187	49	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR047-02	3000.00	W	ACTIVE	Shop floor C, Kolhapur	2026-07-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
188	49	CNC Press Brake 100T #4	Press Brake	PB-100	SN-MFR047-03	100.00	tonne	MAINTENANCE	Shop floor A, Kolhapur	2026-07-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
189	49	Hydraulic Power Press 250T #5	Power Press	HP-250	SN-MFR047-04	250.00	tonne	ACTIVE	Shop floor B, Kolhapur	2026-07-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
190	50	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR048-00	300.00	mm length	ACTIVE	Shop floor A, Hosur	2026-07-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
191	50	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR048-01	400.00	mm table	ACTIVE	Shop floor B, Hosur	2026-07-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
192	50	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR048-02	2000.00	kg	ACTIVE	Shop floor C, Hosur	2026-07-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
193	51	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR049-00	6.00	axis	ACTIVE	Shop floor A, Gurugram	2026-06-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
194	51	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR049-01	300.00	mm length	ACTIVE	Shop floor B, Gurugram	2026-06-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
195	51	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR049-02	400.00	mm table	ACTIVE	Shop floor C, Gurugram	2026-06-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
196	51	Closed-Die Forging Hammer 2T #4	Forging Hammer	FH-2000	SN-MFR049-03	2000.00	kg	MAINTENANCE	Shop floor A, Gurugram	2026-06-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
197	52	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR050-00	400.00	mm table	ACTIVE	Shop floor A, Pune	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
198	52	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR050-01	2000.00	kg	ACTIVE	Shop floor B, Pune	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
199	52	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR050-02	400.00	mm X-travel	ACTIVE	Shop floor C, Pune	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
200	52	Powder Coating Line #4	Surface Finishing	PCL-2	SN-MFR050-03	2.00	m/min	MAINTENANCE	Shop floor A, Pune	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
201	52	VMC-850 Vertical Machining Centre #5	CNC Vertical Machining Centre	VMC-850	SN-MFR050-04	850.00	mm X-travel	ACTIVE	Shop floor B, Pune	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
202	53	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR051-00	850.00	mm X-travel	ACTIVE	Shop floor A, Vadodara	2026-06-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
203	53	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR051-01	250.00	mm swing	ACTIVE	Shop floor B, Vadodara	2026-06-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
204	53	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR051-02	500.00	mm pallet	ACTIVE	Shop floor C, Vadodara	2026-06-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
205	54	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR052-00	500.00	kg/heat	ACTIVE	Shop floor A, Hyderabad	2026-06-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
206	54	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR052-01	400.00	tonne	ACTIVE	Shop floor B, Hyderabad	2026-06-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
207	54	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR052-02	180.00	tonne	ACTIVE	Shop floor C, Hyderabad	2026-06-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
208	54	MIG Welding Robot Cell #4	Robotic Welding	RW-6A	SN-MFR052-03	6.00	axis	MAINTENANCE	Shop floor A, Hyderabad	2026-06-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
209	55	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR053-00	2000.00	kg	ACTIVE	Shop floor A, Indore	2026-06-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
210	55	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR053-01	400.00	mm X-travel	ACTIVE	Shop floor B, Indore	2026-06-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
211	55	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR053-02	2.00	m/min	ACTIVE	Shop floor C, Indore	2026-06-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
212	55	VMC-850 Vertical Machining Centre #4	CNC Vertical Machining Centre	VMC-850	SN-MFR053-03	850.00	mm X-travel	MAINTENANCE	Shop floor A, Indore	2026-06-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
213	55	CNC Turning Centre TC-250 #5	CNC Lathe	TC-250	SN-MFR053-04	250.00	mm swing	ACTIVE	Shop floor B, Indore	2026-06-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
214	56	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR054-00	3000.00	W	ACTIVE	Shop floor A, Aurangabad	2026-06-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
215	56	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR054-01	100.00	tonne	ACTIVE	Shop floor B, Aurangabad	2026-06-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
216	56	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR054-02	250.00	tonne	ACTIVE	Shop floor C, Aurangabad	2026-06-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
217	57	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR055-00	180.00	tonne	ACTIVE	Shop floor A, Coimbatore	2026-06-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
218	57	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR055-01	6.00	axis	ACTIVE	Shop floor B, Coimbatore	2026-06-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
219	57	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR055-02	300.00	mm length	ACTIVE	Shop floor C, Coimbatore	2026-06-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
220	57	5-Axis Machining Centre #4	CNC 5-Axis	FA-5X400	SN-MFR055-03	400.00	mm table	MAINTENANCE	Shop floor A, Coimbatore	2026-06-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
221	58	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR056-00	400.00	tonne	ACTIVE	Shop floor A, Faridabad	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
222	58	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR056-01	180.00	tonne	ACTIVE	Shop floor B, Faridabad	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
223	58	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR056-02	6.00	axis	ACTIVE	Shop floor C, Faridabad	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
224	58	Cylindrical Grinder CG-300 #4	Grinding	CG-300	SN-MFR056-03	300.00	mm length	MAINTENANCE	Shop floor A, Faridabad	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
225	58	5-Axis Machining Centre #5	CNC 5-Axis	FA-5X400	SN-MFR056-04	400.00	mm table	ACTIVE	Shop floor B, Faridabad	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
226	59	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR057-00	250.00	mm swing	ACTIVE	Shop floor A, Visakhapatnam	2026-06-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
227	59	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR057-01	500.00	mm pallet	ACTIVE	Shop floor B, Visakhapatnam	2026-06-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
228	59	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR057-02	3000.00	W	ACTIVE	Shop floor C, Visakhapatnam	2026-06-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
229	60	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR058-00	300.00	mm length	ACTIVE	Shop floor A, Ahmedabad	2026-06-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
230	60	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR058-01	400.00	mm table	ACTIVE	Shop floor B, Ahmedabad	2026-06-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
231	60	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR058-02	2000.00	kg	ACTIVE	Shop floor C, Ahmedabad	2026-06-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
232	60	Wire EDM W-400 #4	Wire EDM	WEDM-400	SN-MFR058-03	400.00	mm X-travel	MAINTENANCE	Shop floor A, Ahmedabad	2026-06-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
233	61	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR059-00	6.00	axis	ACTIVE	Shop floor A, Mysuru	2026-05-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
234	61	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR059-01	300.00	mm length	ACTIVE	Shop floor B, Mysuru	2026-05-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
235	61	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR059-02	400.00	mm table	ACTIVE	Shop floor C, Mysuru	2026-05-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
236	61	Closed-Die Forging Hammer 2T #4	Forging Hammer	FH-2000	SN-MFR059-03	2000.00	kg	MAINTENANCE	Shop floor A, Mysuru	2026-05-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
237	61	Wire EDM W-400 #5	Wire EDM	WEDM-400	SN-MFR059-04	400.00	mm X-travel	ACTIVE	Shop floor B, Mysuru	2026-05-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
238	62	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR060-00	400.00	mm table	ACTIVE	Shop floor A, Jaipur	2026-05-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
239	62	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR060-01	2000.00	kg	ACTIVE	Shop floor B, Jaipur	2026-05-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
240	62	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR060-02	400.00	mm X-travel	ACTIVE	Shop floor C, Jaipur	2026-05-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
241	63	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR061-00	850.00	mm X-travel	ACTIVE	Shop floor A, Nashik	2026-05-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
242	63	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR061-01	250.00	mm swing	ACTIVE	Shop floor B, Nashik	2026-05-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
243	63	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR061-02	500.00	mm pallet	ACTIVE	Shop floor C, Nashik	2026-05-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
244	63	Fiber Laser Cutter 3 kW #4	Laser Cutting	FL-3015	SN-MFR061-03	3000.00	W	MAINTENANCE	Shop floor A, Nashik	2026-05-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
245	64	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR062-00	500.00	kg/heat	ACTIVE	Shop floor A, Chennai	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
246	64	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR062-01	400.00	tonne	ACTIVE	Shop floor B, Chennai	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
247	64	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR062-02	180.00	tonne	ACTIVE	Shop floor C, Chennai	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
248	64	MIG Welding Robot Cell #4	Robotic Welding	RW-6A	SN-MFR062-03	6.00	axis	MAINTENANCE	Shop floor A, Chennai	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
249	64	Cylindrical Grinder CG-300 #5	Grinding	CG-300	SN-MFR062-04	300.00	mm length	ACTIVE	Shop floor B, Chennai	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
250	65	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR063-00	2000.00	kg	ACTIVE	Shop floor A, Mohali	2026-05-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
251	65	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR063-01	400.00	mm X-travel	ACTIVE	Shop floor B, Mohali	2026-05-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
252	65	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR063-02	2.00	m/min	ACTIVE	Shop floor C, Mohali	2026-05-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
253	66	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR064-00	3000.00	W	ACTIVE	Shop floor A, Jamshedpur	2026-05-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
254	66	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR064-01	100.00	tonne	ACTIVE	Shop floor B, Jamshedpur	2026-05-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
255	66	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR064-02	250.00	tonne	ACTIVE	Shop floor C, Jamshedpur	2026-05-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
256	66	Induction Furnace 500 kg #4	Melting Furnace	IF-500	SN-MFR064-03	500.00	kg/heat	MAINTENANCE	Shop floor A, Jamshedpur	2026-05-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
257	67	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR065-00	180.00	tonne	ACTIVE	Shop floor A, Rajkot	2026-05-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
258	67	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR065-01	6.00	axis	ACTIVE	Shop floor B, Rajkot	2026-05-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
259	67	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR065-02	300.00	mm length	ACTIVE	Shop floor C, Rajkot	2026-05-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
260	67	5-Axis Machining Centre #4	CNC 5-Axis	FA-5X400	SN-MFR065-03	400.00	mm table	MAINTENANCE	Shop floor A, Rajkot	2026-05-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
261	67	Closed-Die Forging Hammer 2T #5	Forging Hammer	FH-2000	SN-MFR065-04	2000.00	kg	ACTIVE	Shop floor B, Rajkot	2026-05-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
262	68	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR066-00	400.00	tonne	ACTIVE	Shop floor A, Bengaluru	2026-05-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
263	68	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR066-01	180.00	tonne	ACTIVE	Shop floor B, Bengaluru	2026-05-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
264	68	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR066-02	6.00	axis	ACTIVE	Shop floor C, Bengaluru	2026-05-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
265	69	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR067-00	250.00	mm swing	ACTIVE	Shop floor A, Noida	2026-05-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
266	69	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR067-01	500.00	mm pallet	ACTIVE	Shop floor B, Noida	2026-05-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
267	69	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR067-02	3000.00	W	ACTIVE	Shop floor C, Noida	2026-05-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
268	69	CNC Press Brake 100T #4	Press Brake	PB-100	SN-MFR067-03	100.00	tonne	MAINTENANCE	Shop floor A, Noida	2026-05-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
269	70	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR068-00	300.00	mm length	ACTIVE	Shop floor A, Mumbai	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
270	70	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR068-01	400.00	mm table	ACTIVE	Shop floor B, Mumbai	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
271	70	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR068-02	2000.00	kg	ACTIVE	Shop floor C, Mumbai	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
272	70	Wire EDM W-400 #4	Wire EDM	WEDM-400	SN-MFR068-03	400.00	mm X-travel	MAINTENANCE	Shop floor A, Mumbai	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
273	70	Powder Coating Line #5	Surface Finishing	PCL-2	SN-MFR068-04	2.00	m/min	ACTIVE	Shop floor B, Mumbai	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
274	71	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR069-00	6.00	axis	ACTIVE	Shop floor A, Surat	2026-05-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
275	71	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR069-01	300.00	mm length	ACTIVE	Shop floor B, Surat	2026-05-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
276	71	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR069-02	400.00	mm table	ACTIVE	Shop floor C, Surat	2026-05-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
277	72	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR070-00	400.00	mm table	ACTIVE	Shop floor A, Ludhiana	2026-04-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
278	72	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR070-01	2000.00	kg	ACTIVE	Shop floor B, Ludhiana	2026-04-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
279	72	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR070-02	400.00	mm X-travel	ACTIVE	Shop floor C, Ludhiana	2026-04-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
280	72	Powder Coating Line #4	Surface Finishing	PCL-2	SN-MFR070-03	2.00	m/min	MAINTENANCE	Shop floor A, Ludhiana	2026-04-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
281	73	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR071-00	850.00	mm X-travel	ACTIVE	Shop floor A, Kolkata	2026-04-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
282	73	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR071-01	250.00	mm swing	ACTIVE	Shop floor B, Kolkata	2026-04-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
283	73	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR071-02	500.00	mm pallet	ACTIVE	Shop floor C, Kolkata	2026-04-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
284	73	Fiber Laser Cutter 3 kW #4	Laser Cutting	FL-3015	SN-MFR071-03	3000.00	W	MAINTENANCE	Shop floor A, Kolkata	2026-04-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
285	73	CNC Press Brake 100T #5	Press Brake	PB-100	SN-MFR071-04	100.00	tonne	ACTIVE	Shop floor B, Kolkata	2026-04-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
286	74	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR072-00	500.00	kg/heat	ACTIVE	Shop floor A, Kolhapur	2026-04-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
287	74	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR072-01	400.00	tonne	ACTIVE	Shop floor B, Kolhapur	2026-04-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
288	74	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR072-02	180.00	tonne	ACTIVE	Shop floor C, Kolhapur	2026-04-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
289	75	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR073-00	2000.00	kg	ACTIVE	Shop floor A, Hosur	2026-04-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
290	75	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR073-01	400.00	mm X-travel	ACTIVE	Shop floor B, Hosur	2026-04-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
291	75	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR073-02	2.00	m/min	ACTIVE	Shop floor C, Hosur	2026-04-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
292	75	VMC-850 Vertical Machining Centre #4	CNC Vertical Machining Centre	VMC-850	SN-MFR073-03	850.00	mm X-travel	MAINTENANCE	Shop floor A, Hosur	2026-04-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
293	76	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR074-00	3000.00	W	ACTIVE	Shop floor A, Gurugram	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
294	76	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR074-01	100.00	tonne	ACTIVE	Shop floor B, Gurugram	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
295	76	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR074-02	250.00	tonne	ACTIVE	Shop floor C, Gurugram	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
296	76	Induction Furnace 500 kg #4	Melting Furnace	IF-500	SN-MFR074-03	500.00	kg/heat	MAINTENANCE	Shop floor A, Gurugram	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
297	76	Pressure Die Casting Machine 400T #5	Die Casting	PDC-400	SN-MFR074-04	400.00	tonne	ACTIVE	Shop floor B, Gurugram	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
298	77	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR075-00	180.00	tonne	ACTIVE	Shop floor A, Pune	2026-04-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
299	77	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR075-01	6.00	axis	ACTIVE	Shop floor B, Pune	2026-04-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
300	77	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR075-02	300.00	mm length	ACTIVE	Shop floor C, Pune	2026-04-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
301	78	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR076-00	400.00	tonne	ACTIVE	Shop floor A, Vadodara	2026-04-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
302	78	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR076-01	180.00	tonne	ACTIVE	Shop floor B, Vadodara	2026-04-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
303	78	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR076-02	6.00	axis	ACTIVE	Shop floor C, Vadodara	2026-04-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
304	78	Cylindrical Grinder CG-300 #4	Grinding	CG-300	SN-MFR076-03	300.00	mm length	MAINTENANCE	Shop floor A, Vadodara	2026-04-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
305	79	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR077-00	250.00	mm swing	ACTIVE	Shop floor A, Hyderabad	2026-04-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
306	79	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR077-01	500.00	mm pallet	ACTIVE	Shop floor B, Hyderabad	2026-04-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
307	79	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR077-02	3000.00	W	ACTIVE	Shop floor C, Hyderabad	2026-04-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
308	79	CNC Press Brake 100T #4	Press Brake	PB-100	SN-MFR077-03	100.00	tonne	MAINTENANCE	Shop floor A, Hyderabad	2026-04-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
309	79	Hydraulic Power Press 250T #5	Power Press	HP-250	SN-MFR077-04	250.00	tonne	ACTIVE	Shop floor B, Hyderabad	2026-04-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
310	80	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR078-00	300.00	mm length	ACTIVE	Shop floor A, Indore	2026-04-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
311	80	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR078-01	400.00	mm table	ACTIVE	Shop floor B, Indore	2026-04-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
312	80	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR078-02	2000.00	kg	ACTIVE	Shop floor C, Indore	2026-04-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
313	81	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR079-00	6.00	axis	ACTIVE	Shop floor A, Aurangabad	2026-04-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
314	81	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR079-01	300.00	mm length	ACTIVE	Shop floor B, Aurangabad	2026-04-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
315	81	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR079-02	400.00	mm table	ACTIVE	Shop floor C, Aurangabad	2026-04-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
316	81	Closed-Die Forging Hammer 2T #4	Forging Hammer	FH-2000	SN-MFR079-03	2000.00	kg	MAINTENANCE	Shop floor A, Aurangabad	2026-04-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
317	82	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR080-00	400.00	mm table	ACTIVE	Shop floor A, Coimbatore	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
318	82	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR080-01	2000.00	kg	ACTIVE	Shop floor B, Coimbatore	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
319	82	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR080-02	400.00	mm X-travel	ACTIVE	Shop floor C, Coimbatore	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
320	82	Powder Coating Line #4	Surface Finishing	PCL-2	SN-MFR080-03	2.00	m/min	MAINTENANCE	Shop floor A, Coimbatore	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
321	82	VMC-850 Vertical Machining Centre #5	CNC Vertical Machining Centre	VMC-850	SN-MFR080-04	850.00	mm X-travel	ACTIVE	Shop floor B, Coimbatore	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
322	83	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR081-00	850.00	mm X-travel	ACTIVE	Shop floor A, Faridabad	2026-03-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
323	83	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR081-01	250.00	mm swing	ACTIVE	Shop floor B, Faridabad	2026-03-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
324	83	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR081-02	500.00	mm pallet	ACTIVE	Shop floor C, Faridabad	2026-03-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
325	84	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR082-00	500.00	kg/heat	ACTIVE	Shop floor A, Visakhapatnam	2026-03-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
326	84	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR082-01	400.00	tonne	ACTIVE	Shop floor B, Visakhapatnam	2026-03-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
327	84	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR082-02	180.00	tonne	ACTIVE	Shop floor C, Visakhapatnam	2026-03-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
328	84	MIG Welding Robot Cell #4	Robotic Welding	RW-6A	SN-MFR082-03	6.00	axis	MAINTENANCE	Shop floor A, Visakhapatnam	2026-03-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
329	85	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR083-00	2000.00	kg	ACTIVE	Shop floor A, Ahmedabad	2026-03-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
330	85	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR083-01	400.00	mm X-travel	ACTIVE	Shop floor B, Ahmedabad	2026-03-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
331	85	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR083-02	2.00	m/min	ACTIVE	Shop floor C, Ahmedabad	2026-03-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
332	85	VMC-850 Vertical Machining Centre #4	CNC Vertical Machining Centre	VMC-850	SN-MFR083-03	850.00	mm X-travel	MAINTENANCE	Shop floor A, Ahmedabad	2026-03-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
333	85	CNC Turning Centre TC-250 #5	CNC Lathe	TC-250	SN-MFR083-04	250.00	mm swing	ACTIVE	Shop floor B, Ahmedabad	2026-03-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
334	86	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR084-00	3000.00	W	ACTIVE	Shop floor A, Mysuru	2026-03-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
335	86	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR084-01	100.00	tonne	ACTIVE	Shop floor B, Mysuru	2026-03-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
336	86	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR084-02	250.00	tonne	ACTIVE	Shop floor C, Mysuru	2026-03-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
337	87	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR085-00	180.00	tonne	ACTIVE	Shop floor A, Jaipur	2026-03-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
338	87	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR085-01	6.00	axis	ACTIVE	Shop floor B, Jaipur	2026-03-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
339	87	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR085-02	300.00	mm length	ACTIVE	Shop floor C, Jaipur	2026-03-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
340	87	5-Axis Machining Centre #4	CNC 5-Axis	FA-5X400	SN-MFR085-03	400.00	mm table	MAINTENANCE	Shop floor A, Jaipur	2026-03-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
341	88	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR086-00	400.00	tonne	ACTIVE	Shop floor A, Nashik	2026-03-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
342	88	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR086-01	180.00	tonne	ACTIVE	Shop floor B, Nashik	2026-03-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
343	88	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR086-02	6.00	axis	ACTIVE	Shop floor C, Nashik	2026-03-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
344	88	Cylindrical Grinder CG-300 #4	Grinding	CG-300	SN-MFR086-03	300.00	mm length	MAINTENANCE	Shop floor A, Nashik	2026-03-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
345	88	5-Axis Machining Centre #5	CNC 5-Axis	FA-5X400	SN-MFR086-04	400.00	mm table	ACTIVE	Shop floor B, Nashik	2026-03-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
346	89	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR087-00	250.00	mm swing	ACTIVE	Shop floor A, Chennai	2026-03-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
347	89	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR087-01	500.00	mm pallet	ACTIVE	Shop floor B, Chennai	2026-03-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
348	89	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR087-02	3000.00	W	ACTIVE	Shop floor C, Chennai	2026-03-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
349	90	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR088-00	300.00	mm length	ACTIVE	Shop floor A, Mohali	2026-03-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
350	90	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR088-01	400.00	mm table	ACTIVE	Shop floor B, Mohali	2026-03-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
351	90	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR088-02	2000.00	kg	ACTIVE	Shop floor C, Mohali	2026-03-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
352	90	Wire EDM W-400 #4	Wire EDM	WEDM-400	SN-MFR088-03	400.00	mm X-travel	MAINTENANCE	Shop floor A, Mohali	2026-03-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
353	91	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR089-00	6.00	axis	ACTIVE	Shop floor A, Jamshedpur	2026-03-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
354	91	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR089-01	300.00	mm length	ACTIVE	Shop floor B, Jamshedpur	2026-03-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
355	91	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR089-02	400.00	mm table	ACTIVE	Shop floor C, Jamshedpur	2026-03-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
356	91	Closed-Die Forging Hammer 2T #4	Forging Hammer	FH-2000	SN-MFR089-03	2000.00	kg	MAINTENANCE	Shop floor A, Jamshedpur	2026-03-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
357	91	Wire EDM W-400 #5	Wire EDM	WEDM-400	SN-MFR089-04	400.00	mm X-travel	ACTIVE	Shop floor B, Jamshedpur	2026-03-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
358	92	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR090-00	400.00	mm table	ACTIVE	Shop floor A, Rajkot	2026-02-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
359	92	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR090-01	2000.00	kg	ACTIVE	Shop floor B, Rajkot	2026-02-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
360	92	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR090-02	400.00	mm X-travel	ACTIVE	Shop floor C, Rajkot	2026-02-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
361	93	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR091-00	850.00	mm X-travel	ACTIVE	Shop floor A, Bengaluru	2026-02-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
362	93	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR091-01	250.00	mm swing	ACTIVE	Shop floor B, Bengaluru	2026-02-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
363	93	Horizontal Machining Centre H-500 #3	CNC Horizontal Machining	HMC-500	SN-MFR091-02	500.00	mm pallet	ACTIVE	Shop floor C, Bengaluru	2026-02-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
364	93	Fiber Laser Cutter 3 kW #4	Laser Cutting	FL-3015	SN-MFR091-03	3000.00	W	MAINTENANCE	Shop floor A, Bengaluru	2026-02-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
365	94	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR092-00	500.00	kg/heat	ACTIVE	Shop floor A, Noida	2026-02-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
366	94	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR092-01	400.00	tonne	ACTIVE	Shop floor B, Noida	2026-02-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
367	94	Injection Moulding Machine 180T #3	Injection Moulding	IM-180	SN-MFR092-02	180.00	tonne	ACTIVE	Shop floor C, Noida	2026-02-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
368	94	MIG Welding Robot Cell #4	Robotic Welding	RW-6A	SN-MFR092-03	6.00	axis	MAINTENANCE	Shop floor A, Noida	2026-02-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
369	94	Cylindrical Grinder CG-300 #5	Grinding	CG-300	SN-MFR092-04	300.00	mm length	ACTIVE	Shop floor B, Noida	2026-02-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
370	95	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR093-00	2000.00	kg	ACTIVE	Shop floor A, Mumbai	2026-02-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
371	95	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR093-01	400.00	mm X-travel	ACTIVE	Shop floor B, Mumbai	2026-02-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
372	95	Powder Coating Line #3	Surface Finishing	PCL-2	SN-MFR093-02	2.00	m/min	ACTIVE	Shop floor C, Mumbai	2026-02-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
373	96	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR094-00	3000.00	W	ACTIVE	Shop floor A, Surat	2026-02-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
374	96	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR094-01	100.00	tonne	ACTIVE	Shop floor B, Surat	2026-02-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
375	96	Hydraulic Power Press 250T #3	Power Press	HP-250	SN-MFR094-02	250.00	tonne	ACTIVE	Shop floor C, Surat	2026-02-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
376	96	Induction Furnace 500 kg #4	Melting Furnace	IF-500	SN-MFR094-03	500.00	kg/heat	MAINTENANCE	Shop floor A, Surat	2026-02-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
377	97	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR095-00	180.00	tonne	ACTIVE	Shop floor A, Ludhiana	2026-02-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
378	97	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR095-01	6.00	axis	ACTIVE	Shop floor B, Ludhiana	2026-02-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
379	97	Cylindrical Grinder CG-300 #3	Grinding	CG-300	SN-MFR095-02	300.00	mm length	ACTIVE	Shop floor C, Ludhiana	2026-02-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
380	97	5-Axis Machining Centre #4	CNC 5-Axis	FA-5X400	SN-MFR095-03	400.00	mm table	MAINTENANCE	Shop floor A, Ludhiana	2026-02-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
381	97	Closed-Die Forging Hammer 2T #5	Forging Hammer	FH-2000	SN-MFR095-04	2000.00	kg	ACTIVE	Shop floor B, Ludhiana	2026-02-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
382	98	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR096-00	400.00	tonne	ACTIVE	Shop floor A, Kolkata	2026-02-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
383	98	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR096-01	180.00	tonne	ACTIVE	Shop floor B, Kolkata	2026-02-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
384	98	MIG Welding Robot Cell #3	Robotic Welding	RW-6A	SN-MFR096-02	6.00	axis	ACTIVE	Shop floor C, Kolkata	2026-02-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
385	99	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR097-00	250.00	mm swing	ACTIVE	Shop floor A, Kolhapur	2026-02-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
386	99	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR097-01	500.00	mm pallet	ACTIVE	Shop floor B, Kolhapur	2026-02-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
387	99	Fiber Laser Cutter 3 kW #3	Laser Cutting	FL-3015	SN-MFR097-02	3000.00	W	ACTIVE	Shop floor C, Kolhapur	2026-02-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
388	99	CNC Press Brake 100T #4	Press Brake	PB-100	SN-MFR097-03	100.00	tonne	MAINTENANCE	Shop floor A, Kolhapur	2026-02-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
389	100	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR098-00	300.00	mm length	ACTIVE	Shop floor A, Hosur	2026-02-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
390	100	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR098-01	400.00	mm table	ACTIVE	Shop floor B, Hosur	2026-02-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
391	100	Closed-Die Forging Hammer 2T #3	Forging Hammer	FH-2000	SN-MFR098-02	2000.00	kg	ACTIVE	Shop floor C, Hosur	2026-02-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
392	100	Wire EDM W-400 #4	Wire EDM	WEDM-400	SN-MFR098-03	400.00	mm X-travel	MAINTENANCE	Shop floor A, Hosur	2026-02-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
393	100	Powder Coating Line #5	Surface Finishing	PCL-2	SN-MFR098-04	2.00	m/min	ACTIVE	Shop floor B, Hosur	2026-02-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
394	101	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR099-00	6.00	axis	ACTIVE	Shop floor A, Gurugram	2026-01-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
395	101	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR099-01	300.00	mm length	ACTIVE	Shop floor B, Gurugram	2026-01-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
396	101	5-Axis Machining Centre #3	CNC 5-Axis	FA-5X400	SN-MFR099-02	400.00	mm table	ACTIVE	Shop floor C, Gurugram	2026-01-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
397	102	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR100-00	400.00	mm table	ACTIVE	Shop floor A, Pune	2026-01-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
398	102	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR100-01	2000.00	kg	ACTIVE	Shop floor B, Pune	2026-01-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
399	102	Wire EDM W-400 #3	Wire EDM	WEDM-400	SN-MFR100-02	400.00	mm X-travel	ACTIVE	Shop floor C, Pune	2026-01-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
400	102	Powder Coating Line #4	Surface Finishing	PCL-2	SN-MFR100-03	2.00	m/min	MAINTENANCE	Shop floor A, Pune	2026-01-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
401	103	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR101-00	850.00	mm X-travel	ACTIVE	Shop floor A, Vadodara	2026-01-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
402	103	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR101-01	250.00	mm swing	ACTIVE	Shop floor B, Vadodara	2026-01-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
403	104	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR102-00	500.00	kg/heat	ACTIVE	Shop floor A, Hyderabad	2026-01-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
404	104	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR102-01	400.00	tonne	ACTIVE	Shop floor B, Hyderabad	2026-01-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
405	105	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR103-00	2000.00	kg	ACTIVE	Shop floor A, Indore	2026-01-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
406	105	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR103-01	400.00	mm X-travel	ACTIVE	Shop floor B, Indore	2026-01-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
407	106	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR104-00	3000.00	W	ACTIVE	Shop floor A, Aurangabad	2026-01-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
408	106	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR104-01	100.00	tonne	ACTIVE	Shop floor B, Aurangabad	2026-01-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
409	107	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR105-00	180.00	tonne	ACTIVE	Shop floor A, Coimbatore	2026-01-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
410	107	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR105-01	6.00	axis	ACTIVE	Shop floor B, Coimbatore	2026-01-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
411	108	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR106-00	400.00	tonne	ACTIVE	Shop floor A, Faridabad	2026-01-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
412	108	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR106-01	180.00	tonne	ACTIVE	Shop floor B, Faridabad	2026-01-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
413	109	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR107-00	250.00	mm swing	ACTIVE	Shop floor A, Visakhapatnam	2026-01-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
414	109	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR107-01	500.00	mm pallet	ACTIVE	Shop floor B, Visakhapatnam	2026-01-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
415	110	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR108-00	300.00	mm length	ACTIVE	Shop floor A, Ahmedabad	2026-01-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
416	110	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR108-01	400.00	mm table	ACTIVE	Shop floor B, Ahmedabad	2026-01-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
417	111	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR109-00	6.00	axis	ACTIVE	Shop floor A, Mysuru	2026-01-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
418	111	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR109-01	300.00	mm length	ACTIVE	Shop floor B, Mysuru	2026-01-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
419	112	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR110-00	400.00	mm table	ACTIVE	Shop floor A, Jaipur	2025-12-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
420	112	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR110-01	2000.00	kg	ACTIVE	Shop floor B, Jaipur	2025-12-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
421	113	VMC-850 Vertical Machining Centre #1	CNC Vertical Machining Centre	VMC-850	SN-MFR111-00	850.00	mm X-travel	ACTIVE	Shop floor A, Nashik	2025-12-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
422	113	CNC Turning Centre TC-250 #2	CNC Lathe	TC-250	SN-MFR111-01	250.00	mm swing	ACTIVE	Shop floor B, Nashik	2025-12-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
423	114	Induction Furnace 500 kg #1	Melting Furnace	IF-500	SN-MFR112-00	500.00	kg/heat	ACTIVE	Shop floor A, Chennai	2025-12-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
424	114	Pressure Die Casting Machine 400T #2	Die Casting	PDC-400	SN-MFR112-01	400.00	tonne	ACTIVE	Shop floor B, Chennai	2025-12-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
425	115	Closed-Die Forging Hammer 2T #1	Forging Hammer	FH-2000	SN-MFR113-00	2000.00	kg	ACTIVE	Shop floor A, Mohali	2025-12-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
426	115	Wire EDM W-400 #2	Wire EDM	WEDM-400	SN-MFR113-01	400.00	mm X-travel	ACTIVE	Shop floor B, Mohali	2025-12-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
427	116	Fiber Laser Cutter 3 kW #1	Laser Cutting	FL-3015	SN-MFR114-00	3000.00	W	ACTIVE	Shop floor A, Jamshedpur	2025-12-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
428	116	CNC Press Brake 100T #2	Press Brake	PB-100	SN-MFR114-01	100.00	tonne	ACTIVE	Shop floor B, Jamshedpur	2025-12-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
429	117	Injection Moulding Machine 180T #1	Injection Moulding	IM-180	SN-MFR115-00	180.00	tonne	ACTIVE	Shop floor A, Rajkot	2025-12-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
430	117	MIG Welding Robot Cell #2	Robotic Welding	RW-6A	SN-MFR115-01	6.00	axis	ACTIVE	Shop floor B, Rajkot	2025-12-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
431	118	Pressure Die Casting Machine 400T #1	Die Casting	PDC-400	SN-MFR116-00	400.00	tonne	INACTIVE	Shop floor A, Bengaluru	2025-12-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
432	118	Injection Moulding Machine 180T #2	Injection Moulding	IM-180	SN-MFR116-01	180.00	tonne	INACTIVE	Shop floor B, Bengaluru	2025-12-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
433	119	CNC Turning Centre TC-250 #1	CNC Lathe	TC-250	SN-MFR117-00	250.00	mm swing	INACTIVE	Shop floor A, Noida	2025-12-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
434	119	Horizontal Machining Centre H-500 #2	CNC Horizontal Machining	HMC-500	SN-MFR117-01	500.00	mm pallet	INACTIVE	Shop floor B, Noida	2025-12-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
435	120	Cylindrical Grinder CG-300 #1	Grinding	CG-300	SN-MFR118-00	300.00	mm length	INACTIVE	Shop floor A, Mumbai	2025-12-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
436	120	5-Axis Machining Centre #2	CNC 5-Axis	FA-5X400	SN-MFR118-01	400.00	mm table	INACTIVE	Shop floor B, Mumbai	2025-12-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
437	121	MIG Welding Robot Cell #1	Robotic Welding	RW-6A	SN-MFR119-00	6.00	axis	INACTIVE	Shop floor A, Surat	2025-12-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
438	121	Cylindrical Grinder CG-300 #2	Grinding	CG-300	SN-MFR119-01	300.00	mm length	INACTIVE	Shop floor B, Surat	2025-12-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
439	122	5-Axis Machining Centre #1	CNC 5-Axis	FA-5X400	SN-MFR120-00	400.00	mm table	INACTIVE	Shop floor A, Ludhiana	2025-11-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
440	122	Closed-Die Forging Hammer 2T #2	Forging Hammer	FH-2000	SN-MFR120-01	2000.00	kg	INACTIVE	Shop floor B, Ludhiana	2025-11-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
441	244	Fiber Laser 3015 #1	Laser Cutting	FL-3015 / SN-PFW-0001	\N	3000.00	W	ACTIVE	Bay A, Chakan	2026-11-25 00:07:46.039265+00	2026-11-25 00:07:46.040259+00
\.


--
-- Data for Name: manufacturer_materials; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.manufacturer_materials (manufacturer_id, material_id) FROM stdin;
2	1
3	2
3	4
3	6
3	9
4	1
4	3
4	5
4	7
5	2
5	4
5	6
5	8
6	3
6	5
6	7
6	9
7	1
7	4
7	6
7	8
8	2
8	5
8	7
8	9
9	1
9	3
9	6
9	8
10	2
10	4
10	7
10	9
11	1
11	3
11	5
11	8
12	2
12	4
12	6
12	9
13	1
13	3
13	5
13	7
14	2
14	4
14	6
14	8
15	3
15	5
15	7
15	9
16	1
16	4
16	6
16	8
17	2
17	5
17	7
17	9
18	1
18	3
18	6
18	8
19	2
19	4
19	7
19	9
20	1
20	3
20	5
20	8
21	2
21	4
21	6
21	9
22	1
22	3
22	5
22	7
23	2
23	4
23	6
23	8
24	3
24	5
24	7
24	9
25	1
25	4
25	6
25	8
26	2
26	5
26	7
26	9
27	1
27	3
27	6
27	8
28	2
28	4
28	7
28	9
29	1
29	3
29	5
29	8
30	2
30	4
30	6
30	9
31	1
31	3
31	5
31	7
32	2
32	4
32	6
32	8
33	3
33	5
33	7
33	9
34	1
34	4
34	6
34	8
35	2
35	5
35	7
35	9
36	1
36	3
36	6
36	8
37	2
37	4
37	7
37	9
38	1
38	3
38	5
38	8
39	2
39	4
39	6
39	9
40	1
40	3
40	5
40	7
41	2
41	4
41	6
41	8
42	3
42	5
42	7
42	9
43	1
43	4
43	6
43	8
44	2
44	5
44	7
44	9
45	1
45	3
45	6
45	8
46	2
46	4
46	7
46	9
47	1
47	3
47	5
47	8
48	2
48	4
48	6
48	9
49	1
49	3
49	5
49	7
50	2
50	4
50	6
50	8
51	3
51	5
51	7
51	9
52	1
52	4
52	6
52	8
53	2
53	5
53	7
53	9
54	1
54	3
54	6
54	8
55	2
55	4
55	7
55	9
56	1
56	3
56	5
56	8
57	2
57	4
57	6
57	9
58	1
58	3
58	5
58	7
59	2
59	4
59	6
59	8
60	3
60	5
60	7
60	9
61	1
61	4
61	6
61	8
62	2
62	5
62	7
62	9
63	1
63	3
63	6
63	8
64	2
64	4
64	7
64	9
65	1
65	3
65	5
65	8
66	2
66	4
66	6
66	9
67	1
67	3
67	5
67	7
68	2
68	4
68	6
68	8
69	3
69	5
69	7
69	9
70	1
70	4
70	6
70	8
71	2
71	5
71	7
71	9
72	1
72	3
72	6
72	8
73	2
73	4
73	7
73	9
74	1
74	3
74	5
74	8
75	2
75	4
75	6
75	9
76	1
76	3
76	5
76	7
77	2
77	4
77	6
77	8
78	3
78	5
78	7
78	9
79	1
79	4
79	6
79	8
80	2
80	5
80	7
80	9
81	1
81	3
81	6
81	8
82	2
82	4
82	7
82	9
83	1
83	3
83	5
83	8
84	2
84	4
84	6
84	9
85	1
85	3
85	5
85	7
86	2
86	4
86	6
86	8
87	3
87	5
87	7
87	9
88	1
88	4
88	6
88	8
89	2
89	5
89	7
89	9
90	1
90	3
90	6
90	8
91	2
91	4
91	7
91	9
92	1
92	3
92	5
92	8
93	2
93	4
93	6
93	9
94	1
94	3
94	5
94	7
95	2
95	4
95	6
95	8
96	3
96	5
96	7
96	9
97	1
97	4
97	6
97	8
98	2
98	5
98	7
98	9
99	1
99	3
99	6
99	8
100	2
100	4
100	7
100	9
101	1
101	3
101	5
101	8
102	2
102	4
102	6
102	9
103	1
103	3
103	5
103	7
104	2
104	4
104	6
104	8
105	3
105	5
105	7
105	9
106	1
106	4
106	6
106	8
107	2
107	5
107	7
107	9
108	1
108	3
108	6
108	8
109	2
109	4
109	7
109	9
110	1
110	3
110	5
110	8
111	2
111	4
111	6
111	9
112	1
112	3
112	5
112	7
113	2
113	4
113	6
113	8
114	3
114	5
114	7
114	9
115	1
115	4
115	6
115	8
116	2
116	5
116	7
116	9
117	1
117	3
117	6
117	8
118	2
118	4
118	7
118	9
119	1
119	3
119	5
119	8
120	2
120	4
120	6
120	9
121	1
121	3
121	5
121	7
122	2
122	4
122	6
122	8
244	2
244	1
\.


--
-- Data for Name: manufacturer_processes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.manufacturer_processes (manufacturer_id, process_id) FROM stdin;
2	5
3	2
3	5
3	7
4	3
4	6
4	8
5	1
5	4
5	7
6	2
6	5
6	8
7	1
7	3
7	6
8	2
8	4
8	7
9	3
9	5
9	8
10	1
10	4
10	6
11	2
11	5
11	7
12	3
12	6
12	8
13	1
13	4
13	7
14	2
14	5
14	8
15	1
15	3
15	6
16	2
16	4
16	7
17	3
17	5
17	8
18	1
18	4
18	6
19	2
19	5
19	7
20	3
20	6
20	8
21	1
21	4
21	7
22	2
22	5
22	8
23	1
23	3
23	6
24	2
24	4
24	7
25	3
25	5
25	8
26	1
26	4
26	6
27	2
27	5
27	7
28	3
28	6
28	8
29	1
29	4
29	7
30	2
30	5
30	8
31	1
31	3
31	6
32	2
32	4
32	7
33	3
33	5
33	8
34	1
34	4
34	6
35	2
35	5
35	7
36	3
36	6
36	8
37	1
37	4
37	7
38	2
38	5
38	8
39	1
39	3
39	6
40	2
40	4
40	7
41	3
41	5
41	8
42	1
42	4
42	6
43	2
43	5
43	7
44	3
44	6
44	8
45	1
45	4
45	7
46	2
46	5
46	8
47	1
47	3
47	6
48	2
48	4
48	7
49	3
49	5
49	8
50	1
50	4
50	6
51	2
51	5
51	7
52	3
52	6
52	8
53	1
53	4
53	7
54	2
54	5
54	8
55	1
55	3
55	6
56	2
56	4
56	7
57	3
57	5
57	8
58	1
58	4
58	6
59	2
59	5
59	7
60	3
60	6
60	8
61	1
61	4
61	7
62	2
62	5
62	8
63	1
63	3
63	6
64	2
64	4
64	7
65	3
65	5
65	8
66	1
66	4
66	6
67	2
67	5
67	7
68	3
68	6
68	8
69	1
69	4
69	7
70	2
70	5
70	8
71	1
71	3
71	6
72	2
72	4
72	7
73	3
73	5
73	8
74	1
74	4
74	6
75	2
75	5
75	7
76	3
76	6
76	8
77	1
77	4
77	7
78	2
78	5
78	8
79	1
79	3
79	6
80	2
80	4
80	7
81	3
81	5
81	8
82	1
82	4
82	6
83	2
83	5
83	7
84	3
84	6
84	8
85	1
85	4
85	7
86	2
86	5
86	8
87	1
87	3
87	6
88	2
88	4
88	7
89	3
89	5
89	8
90	1
90	4
90	6
91	2
91	5
91	7
92	3
92	6
92	8
93	1
93	4
93	7
94	2
94	5
94	8
95	1
95	3
95	6
96	2
96	4
96	7
97	3
97	5
97	8
98	1
98	4
98	6
99	2
99	5
99	7
100	3
100	6
100	8
101	1
101	4
101	7
102	2
102	5
102	8
103	1
103	3
103	6
104	2
104	4
104	7
105	3
105	5
105	8
106	1
106	4
106	6
107	2
107	5
107	7
108	3
108	6
108	8
109	1
109	4
109	7
110	2
110	5
110	8
111	1
111	3
111	6
112	2
112	4
112	7
113	3
113	5
113	8
114	1
114	4
114	6
115	2
115	5
115	7
116	3
116	6
116	8
117	1
117	4
117	7
118	2
118	5
118	8
119	1
119	3
119	6
120	2
120	4
120	7
121	3
121	5
121	8
122	1
122	4
122	6
244	2
244	4
\.


--
-- Data for Name: manufacturer_profiles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.manufacturer_profiles (organization_id, description, years_in_operation, website_url, verification_notes, approved_at, approved_by, created_at, updated_at) FROM stdin;
2	\N	\N	\N	\N	\N	\N	2026-11-24 13:09:38.456757+00	2026-11-24 13:09:38.456757+00
3	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Vadodara.	8	\N	GSTIN and registration certificate checked.	2026-11-22 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
4	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Hyderabad.	15	\N	GSTIN and registration certificate checked.	2026-11-20 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
5	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Indore.	22	https://mfr003.example.in	GSTIN and registration certificate checked.	2026-11-18 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
6	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Aurangabad.	29	\N	GSTIN and registration certificate checked.	2026-11-16 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
7	Plastic injection moulding 40T to 350T with in-house tool room. Based in Coimbatore.	1	\N	GSTIN and registration certificate checked.	2026-11-14 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
8	Aluminium pressure die casting with CNC finishing and impregnation. Based in Faridabad.	8	https://mfr006.example.in	GSTIN and registration certificate checked.	2026-11-12 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
9	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Visakhapatnam.	15	\N	GSTIN and registration certificate checked.	2026-11-10 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
10	High-volume CNC machining and grinding of transmission components. Based in Ahmedabad.	22	\N	GSTIN and registration certificate checked.	2026-11-08 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
11	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Mysuru.	29	https://mfr009.example.in	GSTIN and registration certificate checked.	2026-11-06 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
12	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Jaipur.	1	\N	GSTIN and registration certificate checked.	2026-11-04 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
13	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Nashik.	8	\N	GSTIN and registration certificate checked.	2026-11-02 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
14	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Chennai.	15	https://mfr012.example.in	GSTIN and registration certificate checked.	2026-10-31 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
15	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Mohali.	22	\N	GSTIN and registration certificate checked.	2026-10-29 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
16	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Jamshedpur.	29	\N	GSTIN and registration certificate checked.	2026-10-27 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
17	Plastic injection moulding 40T to 350T with in-house tool room. Based in Rajkot.	1	https://mfr015.example.in	GSTIN and registration certificate checked.	2026-10-25 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
18	Aluminium pressure die casting with CNC finishing and impregnation. Based in Bengaluru.	8	\N	GSTIN and registration certificate checked.	2026-10-23 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
19	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Noida.	15	\N	GSTIN and registration certificate checked.	2026-10-21 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
20	High-volume CNC machining and grinding of transmission components. Based in Mumbai.	22	https://mfr018.example.in	GSTIN and registration certificate checked.	2026-10-19 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
21	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Surat.	29	\N	GSTIN and registration certificate checked.	2026-10-17 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
22	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Ludhiana.	1	\N	GSTIN and registration certificate checked.	2026-10-15 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
23	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Kolkata.	8	https://mfr021.example.in	GSTIN and registration certificate checked.	2026-10-13 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
24	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Kolhapur.	15	\N	GSTIN and registration certificate checked.	2026-10-11 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
25	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Hosur.	22	\N	GSTIN and registration certificate checked.	2026-10-09 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
26	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Gurugram.	29	https://mfr024.example.in	GSTIN and registration certificate checked.	2026-10-07 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
27	Plastic injection moulding 40T to 350T with in-house tool room. Based in Pune.	1	\N	GSTIN and registration certificate checked.	2026-10-05 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
28	Aluminium pressure die casting with CNC finishing and impregnation. Based in Vadodara.	8	\N	GSTIN and registration certificate checked.	2026-10-03 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
29	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Hyderabad.	15	https://mfr027.example.in	GSTIN and registration certificate checked.	2026-10-01 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
30	High-volume CNC machining and grinding of transmission components. Based in Indore.	22	\N	GSTIN and registration certificate checked.	2026-09-29 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
31	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Aurangabad.	29	\N	GSTIN and registration certificate checked.	2026-09-27 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
32	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Coimbatore.	1	https://mfr030.example.in	GSTIN and registration certificate checked.	2026-09-25 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
33	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Faridabad.	8	\N	GSTIN and registration certificate checked.	2026-09-23 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
34	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Visakhapatnam.	15	\N	GSTIN and registration certificate checked.	2026-09-21 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
35	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Ahmedabad.	22	https://mfr033.example.in	GSTIN and registration certificate checked.	2026-09-19 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
36	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Mysuru.	29	\N	GSTIN and registration certificate checked.	2026-09-17 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
37	Plastic injection moulding 40T to 350T with in-house tool room. Based in Jaipur.	1	\N	GSTIN and registration certificate checked.	2026-09-15 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
38	Aluminium pressure die casting with CNC finishing and impregnation. Based in Nashik.	8	https://mfr036.example.in	GSTIN and registration certificate checked.	2026-09-13 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
39	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Chennai.	15	\N	GSTIN and registration certificate checked.	2026-09-11 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
40	High-volume CNC machining and grinding of transmission components. Based in Mohali.	22	\N	GSTIN and registration certificate checked.	2026-09-09 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
41	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Jamshedpur.	29	https://mfr039.example.in	GSTIN and registration certificate checked.	2026-09-07 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
42	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Rajkot.	1	\N	GSTIN and registration certificate checked.	2026-09-05 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
43	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Bengaluru.	8	\N	GSTIN and registration certificate checked.	2026-09-03 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
44	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Noida.	15	https://mfr042.example.in	GSTIN and registration certificate checked.	2026-09-01 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
45	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Mumbai.	22	\N	GSTIN and registration certificate checked.	2026-08-30 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
46	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Surat.	29	\N	GSTIN and registration certificate checked.	2026-08-28 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
47	Plastic injection moulding 40T to 350T with in-house tool room. Based in Ludhiana.	1	https://mfr045.example.in	GSTIN and registration certificate checked.	2026-08-26 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
48	Aluminium pressure die casting with CNC finishing and impregnation. Based in Kolkata.	8	\N	GSTIN and registration certificate checked.	2026-08-24 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
49	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Kolhapur.	15	\N	GSTIN and registration certificate checked.	2026-08-22 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
50	High-volume CNC machining and grinding of transmission components. Based in Hosur.	22	https://mfr048.example.in	GSTIN and registration certificate checked.	2026-08-20 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
51	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Gurugram.	29	\N	GSTIN and registration certificate checked.	2026-08-18 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
52	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Pune.	1	\N	GSTIN and registration certificate checked.	2026-08-16 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
53	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Vadodara.	8	https://mfr051.example.in	GSTIN and registration certificate checked.	2026-08-14 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
54	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Hyderabad.	15	\N	GSTIN and registration certificate checked.	2026-08-12 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
55	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Indore.	22	\N	GSTIN and registration certificate checked.	2026-08-10 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
56	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Aurangabad.	29	https://mfr054.example.in	GSTIN and registration certificate checked.	2026-08-08 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
57	Plastic injection moulding 40T to 350T with in-house tool room. Based in Coimbatore.	1	\N	GSTIN and registration certificate checked.	2026-08-06 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
58	Aluminium pressure die casting with CNC finishing and impregnation. Based in Faridabad.	8	\N	GSTIN and registration certificate checked.	2026-08-04 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
59	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Visakhapatnam.	15	https://mfr057.example.in	GSTIN and registration certificate checked.	2026-08-02 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
60	High-volume CNC machining and grinding of transmission components. Based in Ahmedabad.	22	\N	GSTIN and registration certificate checked.	2026-07-31 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
61	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Mysuru.	29	\N	GSTIN and registration certificate checked.	2026-07-29 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
62	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Jaipur.	1	https://mfr060.example.in	GSTIN and registration certificate checked.	2026-07-27 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
63	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Nashik.	8	\N	GSTIN and registration certificate checked.	2026-07-25 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
64	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Chennai.	15	\N	GSTIN and registration certificate checked.	2026-07-23 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
65	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Mohali.	22	https://mfr063.example.in	GSTIN and registration certificate checked.	2026-07-21 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
66	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Jamshedpur.	29	\N	GSTIN and registration certificate checked.	2026-07-19 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
67	Plastic injection moulding 40T to 350T with in-house tool room. Based in Rajkot.	1	\N	GSTIN and registration certificate checked.	2026-07-17 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
68	Aluminium pressure die casting with CNC finishing and impregnation. Based in Bengaluru.	8	https://mfr066.example.in	GSTIN and registration certificate checked.	2026-07-15 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
69	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Noida.	15	\N	GSTIN and registration certificate checked.	2026-07-13 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
70	High-volume CNC machining and grinding of transmission components. Based in Mumbai.	22	\N	GSTIN and registration certificate checked.	2026-07-11 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
71	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Surat.	29	https://mfr069.example.in	GSTIN and registration certificate checked.	2026-07-09 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
72	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Ludhiana.	1	\N	GSTIN and registration certificate checked.	2026-07-07 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
73	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Kolkata.	8	\N	GSTIN and registration certificate checked.	2026-07-05 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
74	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Kolhapur.	15	https://mfr072.example.in	GSTIN and registration certificate checked.	2026-07-03 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
75	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Hosur.	22	\N	GSTIN and registration certificate checked.	2026-07-01 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
76	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Gurugram.	29	\N	GSTIN and registration certificate checked.	2026-06-29 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
77	Plastic injection moulding 40T to 350T with in-house tool room. Based in Pune.	1	https://mfr075.example.in	GSTIN and registration certificate checked.	2026-06-27 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
78	Aluminium pressure die casting with CNC finishing and impregnation. Based in Vadodara.	8	\N	GSTIN and registration certificate checked.	2026-06-25 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
79	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Hyderabad.	15	\N	GSTIN and registration certificate checked.	2026-06-23 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
80	High-volume CNC machining and grinding of transmission components. Based in Indore.	22	https://mfr078.example.in	GSTIN and registration certificate checked.	2026-06-21 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
81	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Aurangabad.	29	\N	GSTIN and registration certificate checked.	2026-06-19 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
82	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Coimbatore.	1	\N	GSTIN and registration certificate checked.	2026-06-17 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
83	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Faridabad.	8	https://mfr081.example.in	GSTIN and registration certificate checked.	2026-06-15 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
84	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Visakhapatnam.	15	\N	GSTIN and registration certificate checked.	2026-06-13 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
85	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Ahmedabad.	22	\N	GSTIN and registration certificate checked.	2026-06-11 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
86	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Mysuru.	29	https://mfr084.example.in	GSTIN and registration certificate checked.	2026-06-09 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
87	Plastic injection moulding 40T to 350T with in-house tool room. Based in Jaipur.	1	\N	GSTIN and registration certificate checked.	2026-06-07 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
88	Aluminium pressure die casting with CNC finishing and impregnation. Based in Nashik.	8	\N	GSTIN and registration certificate checked.	2026-06-05 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
89	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Chennai.	15	https://mfr087.example.in	GSTIN and registration certificate checked.	2026-06-03 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
90	High-volume CNC machining and grinding of transmission components. Based in Mohali.	22	\N	GSTIN and registration certificate checked.	2026-06-01 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
91	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Jamshedpur.	29	\N	GSTIN and registration certificate checked.	2026-05-30 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
92	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Rajkot.	1	https://mfr090.example.in	GSTIN and registration certificate checked.	2026-05-28 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
93	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Bengaluru.	8	\N	GSTIN and registration certificate checked.	2026-05-26 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
94	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Noida.	15	\N	GSTIN and registration certificate checked.	2026-05-24 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
95	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Mumbai.	22	https://mfr093.example.in	GSTIN and registration certificate checked.	2026-05-22 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
96	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Surat.	29	\N	GSTIN and registration certificate checked.	2026-05-20 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
97	Plastic injection moulding 40T to 350T with in-house tool room. Based in Ludhiana.	1	\N	GSTIN and registration certificate checked.	2026-05-18 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
98	Aluminium pressure die casting with CNC finishing and impregnation. Based in Kolkata.	8	https://mfr096.example.in	GSTIN and registration certificate checked.	2026-05-16 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
99	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Kolhapur.	15	\N	GSTIN and registration certificate checked.	2026-05-14 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
100	High-volume CNC machining and grinding of transmission components. Based in Hosur.	22	\N	GSTIN and registration certificate checked.	2026-05-12 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
101	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Gurugram.	29	https://mfr099.example.in	GSTIN and registration certificate checked.	2026-05-10 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
102	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Pune.	1	\N	GSTIN and registration certificate checked.	2026-05-08 15:55:54.490593+00	1	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
103	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Vadodara.	8	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
104	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Hyderabad.	15	https://mfr102.example.in	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
105	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Indore.	22	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
106	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Aurangabad.	29	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
107	Plastic injection moulding 40T to 350T with in-house tool room. Based in Coimbatore.	1	https://mfr105.example.in	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
108	Aluminium pressure die casting with CNC finishing and impregnation. Based in Faridabad.	8	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
109	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Visakhapatnam.	15	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
110	High-volume CNC machining and grinding of transmission components. Based in Ahmedabad.	22	https://mfr108.example.in	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
111	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Mysuru.	29	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
112	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Jaipur.	1	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
113	CNC turning and milling of shafts, flanges and housings. CMM inspection in-house. Based in Nashik.	8	https://mfr111.example.in	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
114	Grey and SG iron castings, pattern shop and induction melting for pump and valve bodies. Based in Chennai.	15	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
115	Closed-die forgings in carbon and alloy steel with heat treatment and finish machining. Based in Mohali.	22	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
116	Laser cutting, CNC bending, welding and powder coating of enclosures, brackets and frames. Based in Jamshedpur.	29	https://mfr114.example.in	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
117	Plastic injection moulding 40T to 350T with in-house tool room. Based in Rajkot.	1	\N	\N	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
118	Aluminium pressure die casting with CNC finishing and impregnation. Based in Bengaluru.	8	\N	GSTIN does not match legal name; no address proof.	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
119	Job shop for turned parts, grinding and assembly with fast prototype turnaround. Based in Noida.	15	https://mfr117.example.in	GSTIN does not match legal name; no address proof.	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
120	High-volume CNC machining and grinding of transmission components. Based in Mumbai.	22	\N	GSTIN does not match legal name; no address proof.	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
121	Heavy fabrication, structural welding and machining of skids and equipment parts. Based in Surat.	29	\N	GSTIN does not match legal name; no address proof.	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
122	5-axis machining, wire EDM and grinding for aerospace and medical prototypes. Based in Ludhiana.	1	https://mfr120.example.in	GSTIN does not match legal name; no address proof.	\N	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
244	Laser cutting, CNC bending and MIG welding of sheet-metal enclosures, brackets and frames. Batch sizes 50 to 10,000.	12	\N	\N	\N	\N	2026-11-24 16:55:50.897204+00	2026-11-24 16:55:50.897204+00
\.


--
-- Data for Name: manufacturing_processes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.manufacturing_processes (id, process_name, description, active) FROM stdin;
1	CNC Machining	Milling and turning of metal and plastic parts	t
2	Laser Cutting	Precision cutting of sheet material	t
3	Sheet Metal Fabrication	Bending, punching and forming of sheet metal	t
4	Welding	MIG, TIG and arc welding of assemblies	t
5	3D Printing	Additive manufacturing (FDM, SLA, SLS)	t
6	Injection Moulding	High-volume plastic part production	t
7	Casting	Sand and die casting of metal parts	t
8	Powder Coating	Surface finishing and corrosion protection	t
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.materials (id, material_name, material_category, description, active) FROM stdin;
1	Mild Steel	Metal	General purpose low-carbon steel	t
2	Stainless Steel 304	Metal	Corrosion resistant stainless steel	t
3	Aluminium 6061	Metal	Lightweight structural aluminium	t
4	Brass	Metal	Copper-zinc alloy	t
5	Copper	Metal	High conductivity copper	t
6	ABS	Plastic	Tough engineering plastic	t
7	Nylon (PA6)	Plastic	Wear resistant engineering plastic	t
8	Polycarbonate	Plastic	Impact resistant transparent plastic	t
9	PLA	Plastic	3D printing filament	t
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (id, user_id, title, message, link_url, read_at, created_at) FROM stdin;
1	14	Payment received for ORD-2026-D000001	Railtech Appliances paid INR 441370.15. You can ship once the order is ready.	/manufacturer/payments	\N	2026-11-24 16:49:00.090096+00
2	255	Your company is verified	You can now receive matching RFQs and send quotations. Note: Documents checked	/manufacturer/dashboard	\N	2026-11-24 17:00:34.543061+00
35	68	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.299362+00
36	84	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.299362+00
37	39	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.333725+00
38	255	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.334727+00
39	17	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.343739+00
40	71	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.346743+00
41	44	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.354998+00
42	73	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.358009+00
43	23	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.365791+00
44	95	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.368818+00
45	57	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.376122+00
46	28	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.381126+00
47	89	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.388119+00
48	55	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.392119+00
49	41	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.398465+00
50	100	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.402352+00
51	12	New RFQ: Battery enclosure bracket	RFQ-2026-CZ8V728E · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/86	\N	2026-11-25 00:13:10.41035+00
52	254	New quotation for Battery enclosure bracket	Patil Fabrication Works Pvt Ltd quoted ₹112,100.00 with a lead time of 12 day(s).	/buyer/quotations/184	2026-11-25 00:17:35.783091+00	2026-11-25 00:15:42.527027+00
53	255	New order ORD-2026-QRKEE74S	Your quotation QTN-2026-ANJAXC2U for Battery enclosure bracket was accepted (₹112,100.00). Book machine time to schedule it.	/manufacturer/orders/61	\N	2026-11-25 00:24:41.669636+00
54	255	Payment received for ORD-2026-QRKEE74S	GreenVolt Energy Pvt Ltd paid INR 112100.00. You can ship once the order is ready.	/manufacturer/payments	\N	2026-11-25 00:25:47.643493+00
55	68	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.65537+00
56	84	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.657399+00
57	39	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.67532+00
58	255	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.688076+00
59	17	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.691111+00
60	71	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.69911+00
61	44	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.702119+00
62	73	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.712545+00
63	23	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.714544+00
64	95	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.724783+00
65	57	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.727068+00
66	28	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.735402+00
67	89	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.7384+00
68	55	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.747362+00
69	41	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.750449+00
71	12	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.76454+00
70	100	New RFQ: Steel mounting bracket - batch 2	RFQ-2026-TBQZCX6X · Laser Cutting · Mild Steel · 500 pcs. Submit your quotation before the deadline.	/manufacturer/rfqs/87	\N	2026-11-25 00:42:11.757387+00
72	254	New quotation for Steel mounting bracket - batch 2	Patil Fabrication Works Pvt Ltd quoted ₹52,380.00 with a lead time of 10 day(s).	/buyer/quotations/185	\N	2026-11-25 00:43:42.134567+00
73	255	New order ORD-2026-SXECNPKH	Your quotation QTN-2026-9CYBXSRQ for Steel mounting bracket - batch 2 was accepted (₹52,380.00). Book machine time to schedule it.	/manufacturer/orders/62	\N	2026-11-25 00:44:36.590478+00
74	255	Payment received for ORD-2026-SXECNPKH	GreenVolt Energy Pvt Ltd paid INR 52380.00. You can ship once the order is ready.	/manufacturer/payments	\N	2026-11-25 00:46:00.610174+00
\.


--
-- Data for Name: organization_members; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organization_members (id, organization_id, user_id, membership_role, active, joined_at) FROM stdin;
1	1	1	OWNER	t	2026-11-24 11:36:22.641277+00
2	1	2	MEMBER	t	2026-11-24 11:36:22.933615+00
3	2	3	OWNER	t	2026-11-24 13:09:38.459684+00
4	3	4	OWNER	t	2026-11-24 15:55:54.490593+00
5	4	5	OWNER	t	2026-11-24 15:55:54.490593+00
6	5	6	OWNER	t	2026-11-24 15:55:54.490593+00
7	6	7	OWNER	t	2026-11-24 15:55:54.490593+00
8	7	8	OWNER	t	2026-11-24 15:55:54.490593+00
9	8	9	OWNER	t	2026-11-24 15:55:54.490593+00
10	9	10	OWNER	t	2026-11-24 15:55:54.490593+00
11	10	11	OWNER	t	2026-11-24 15:55:54.490593+00
12	11	12	OWNER	t	2026-11-24 15:55:54.490593+00
13	12	13	OWNER	t	2026-11-24 15:55:54.490593+00
14	13	14	OWNER	t	2026-11-24 15:55:54.490593+00
15	14	15	OWNER	t	2026-11-24 15:55:54.490593+00
16	15	16	OWNER	t	2026-11-24 15:55:54.490593+00
17	16	17	OWNER	t	2026-11-24 15:55:54.490593+00
18	17	18	OWNER	t	2026-11-24 15:55:54.490593+00
19	18	19	OWNER	t	2026-11-24 15:55:54.490593+00
20	19	20	OWNER	t	2026-11-24 15:55:54.490593+00
21	20	21	OWNER	t	2026-11-24 15:55:54.490593+00
22	21	22	OWNER	t	2026-11-24 15:55:54.490593+00
23	22	23	OWNER	t	2026-11-24 15:55:54.490593+00
24	23	24	OWNER	t	2026-11-24 15:55:54.490593+00
25	24	25	OWNER	t	2026-11-24 15:55:54.490593+00
26	25	26	OWNER	t	2026-11-24 15:55:54.490593+00
27	26	27	OWNER	t	2026-11-24 15:55:54.490593+00
28	27	28	OWNER	t	2026-11-24 15:55:54.490593+00
29	28	29	OWNER	t	2026-11-24 15:55:54.490593+00
30	29	30	OWNER	t	2026-11-24 15:55:54.490593+00
31	30	31	OWNER	t	2026-11-24 15:55:54.490593+00
32	31	32	OWNER	t	2026-11-24 15:55:54.490593+00
33	32	33	OWNER	t	2026-11-24 15:55:54.490593+00
34	33	34	OWNER	t	2026-11-24 15:55:54.490593+00
35	34	35	OWNER	t	2026-11-24 15:55:54.490593+00
36	35	36	OWNER	t	2026-11-24 15:55:54.490593+00
37	36	37	OWNER	t	2026-11-24 15:55:54.490593+00
38	37	38	OWNER	t	2026-11-24 15:55:54.490593+00
39	38	39	OWNER	t	2026-11-24 15:55:54.490593+00
40	39	40	OWNER	t	2026-11-24 15:55:54.490593+00
41	40	41	OWNER	t	2026-11-24 15:55:54.490593+00
42	41	42	OWNER	t	2026-11-24 15:55:54.490593+00
43	42	43	OWNER	t	2026-11-24 15:55:54.490593+00
44	43	44	OWNER	t	2026-11-24 15:55:54.490593+00
45	44	45	OWNER	t	2026-11-24 15:55:54.490593+00
46	45	46	OWNER	t	2026-11-24 15:55:54.490593+00
47	46	47	OWNER	t	2026-11-24 15:55:54.490593+00
48	47	48	OWNER	t	2026-11-24 15:55:54.490593+00
49	48	49	OWNER	t	2026-11-24 15:55:54.490593+00
50	49	50	OWNER	t	2026-11-24 15:55:54.490593+00
51	50	51	OWNER	t	2026-11-24 15:55:54.490593+00
52	51	52	OWNER	t	2026-11-24 15:55:54.490593+00
53	52	53	OWNER	t	2026-11-24 15:55:54.490593+00
54	53	54	OWNER	t	2026-11-24 15:55:54.490593+00
55	54	55	OWNER	t	2026-11-24 15:55:54.490593+00
56	55	56	OWNER	t	2026-11-24 15:55:54.490593+00
57	56	57	OWNER	t	2026-11-24 15:55:54.490593+00
58	57	58	OWNER	t	2026-11-24 15:55:54.490593+00
59	58	59	OWNER	t	2026-11-24 15:55:54.490593+00
60	59	60	OWNER	t	2026-11-24 15:55:54.490593+00
61	60	61	OWNER	t	2026-11-24 15:55:54.490593+00
62	61	62	OWNER	t	2026-11-24 15:55:54.490593+00
63	62	63	OWNER	t	2026-11-24 15:55:54.490593+00
64	63	64	OWNER	t	2026-11-24 15:55:54.490593+00
65	64	65	OWNER	t	2026-11-24 15:55:54.490593+00
66	65	66	OWNER	t	2026-11-24 15:55:54.490593+00
67	66	67	OWNER	t	2026-11-24 15:55:54.490593+00
68	67	68	OWNER	t	2026-11-24 15:55:54.490593+00
69	68	69	OWNER	t	2026-11-24 15:55:54.490593+00
70	69	70	OWNER	t	2026-11-24 15:55:54.490593+00
71	70	71	OWNER	t	2026-11-24 15:55:54.490593+00
72	71	72	OWNER	t	2026-11-24 15:55:54.490593+00
73	72	73	OWNER	t	2026-11-24 15:55:54.490593+00
74	73	74	OWNER	t	2026-11-24 15:55:54.490593+00
75	74	75	OWNER	t	2026-11-24 15:55:54.490593+00
76	75	76	OWNER	t	2026-11-24 15:55:54.490593+00
77	76	77	OWNER	t	2026-11-24 15:55:54.490593+00
78	77	78	OWNER	t	2026-11-24 15:55:54.490593+00
79	78	79	OWNER	t	2026-11-24 15:55:54.490593+00
80	79	80	OWNER	t	2026-11-24 15:55:54.490593+00
81	80	81	OWNER	t	2026-11-24 15:55:54.490593+00
82	81	82	OWNER	t	2026-11-24 15:55:54.490593+00
83	82	83	OWNER	t	2026-11-24 15:55:54.490593+00
84	83	84	OWNER	t	2026-11-24 15:55:54.490593+00
85	84	85	OWNER	t	2026-11-24 15:55:54.490593+00
86	85	86	OWNER	t	2026-11-24 15:55:54.490593+00
87	86	87	OWNER	t	2026-11-24 15:55:54.490593+00
88	87	88	OWNER	t	2026-11-24 15:55:54.490593+00
89	88	89	OWNER	t	2026-11-24 15:55:54.490593+00
90	89	90	OWNER	t	2026-11-24 15:55:54.490593+00
91	90	91	OWNER	t	2026-11-24 15:55:54.490593+00
92	91	92	OWNER	t	2026-11-24 15:55:54.490593+00
93	92	93	OWNER	t	2026-11-24 15:55:54.490593+00
94	93	94	OWNER	t	2026-11-24 15:55:54.490593+00
95	94	95	OWNER	t	2026-11-24 15:55:54.490593+00
96	95	96	OWNER	t	2026-11-24 15:55:54.490593+00
97	96	97	OWNER	t	2026-11-24 15:55:54.490593+00
98	97	98	OWNER	t	2026-11-24 15:55:54.490593+00
99	98	99	OWNER	t	2026-11-24 15:55:54.490593+00
100	99	100	OWNER	t	2026-11-24 15:55:54.490593+00
101	100	101	OWNER	t	2026-11-24 15:55:54.490593+00
102	101	102	OWNER	t	2026-11-24 15:55:54.490593+00
103	102	103	OWNER	t	2026-11-24 15:55:54.490593+00
104	103	104	OWNER	t	2026-11-24 15:55:54.490593+00
105	104	105	OWNER	t	2026-11-24 15:55:54.490593+00
106	105	106	OWNER	t	2026-11-24 15:55:54.490593+00
107	106	107	OWNER	t	2026-11-24 15:55:54.490593+00
108	107	108	OWNER	t	2026-11-24 15:55:54.490593+00
109	108	109	OWNER	t	2026-11-24 15:55:54.490593+00
110	109	110	OWNER	t	2026-11-24 15:55:54.490593+00
111	110	111	OWNER	t	2026-11-24 15:55:54.490593+00
112	111	112	OWNER	t	2026-11-24 15:55:54.490593+00
113	112	113	OWNER	t	2026-11-24 15:55:54.490593+00
114	113	114	OWNER	t	2026-11-24 15:55:54.490593+00
115	114	115	OWNER	t	2026-11-24 15:55:54.490593+00
116	115	116	OWNER	t	2026-11-24 15:55:54.490593+00
117	116	117	OWNER	t	2026-11-24 15:55:54.490593+00
118	117	118	OWNER	t	2026-11-24 15:55:54.490593+00
119	118	119	OWNER	t	2026-11-24 15:55:54.490593+00
120	119	120	OWNER	t	2026-11-24 15:55:54.490593+00
121	120	121	OWNER	t	2026-11-24 15:55:54.490593+00
122	121	122	OWNER	t	2026-11-24 15:55:54.490593+00
123	122	123	OWNER	t	2026-11-24 15:55:54.490593+00
124	123	124	OWNER	t	2026-11-24 15:55:54.490593+00
125	124	125	OWNER	t	2026-11-24 15:55:54.490593+00
126	125	126	OWNER	t	2026-11-24 15:55:54.490593+00
127	126	127	OWNER	t	2026-11-24 15:55:54.490593+00
128	127	128	OWNER	t	2026-11-24 15:55:54.490593+00
129	128	129	OWNER	t	2026-11-24 15:55:54.490593+00
130	129	130	OWNER	t	2026-11-24 15:55:54.490593+00
131	130	131	OWNER	t	2026-11-24 15:55:54.490593+00
132	131	132	OWNER	t	2026-11-24 15:55:54.490593+00
133	132	133	OWNER	t	2026-11-24 15:55:54.490593+00
134	133	134	OWNER	t	2026-11-24 15:55:54.490593+00
135	134	135	OWNER	t	2026-11-24 15:55:54.490593+00
136	135	136	OWNER	t	2026-11-24 15:55:54.490593+00
137	136	137	OWNER	t	2026-11-24 15:55:54.490593+00
138	137	138	OWNER	t	2026-11-24 15:55:54.490593+00
139	138	139	OWNER	t	2026-11-24 15:55:54.490593+00
140	139	140	OWNER	t	2026-11-24 15:55:54.490593+00
141	140	141	OWNER	t	2026-11-24 15:55:54.490593+00
142	141	142	OWNER	t	2026-11-24 15:55:54.490593+00
143	142	143	OWNER	t	2026-11-24 15:55:54.490593+00
144	143	144	OWNER	t	2026-11-24 15:55:54.490593+00
145	144	145	OWNER	t	2026-11-24 15:55:54.490593+00
146	145	146	OWNER	t	2026-11-24 15:55:54.490593+00
147	146	147	OWNER	t	2026-11-24 15:55:54.490593+00
148	147	148	OWNER	t	2026-11-24 15:55:54.490593+00
149	148	149	OWNER	t	2026-11-24 15:55:54.490593+00
150	149	150	OWNER	t	2026-11-24 15:55:54.490593+00
151	150	151	OWNER	t	2026-11-24 15:55:54.490593+00
152	151	152	OWNER	t	2026-11-24 15:55:54.490593+00
153	152	153	OWNER	t	2026-11-24 15:55:54.490593+00
154	153	154	OWNER	t	2026-11-24 15:55:54.490593+00
155	154	155	OWNER	t	2026-11-24 15:55:54.490593+00
156	155	156	OWNER	t	2026-11-24 15:55:54.490593+00
157	156	157	OWNER	t	2026-11-24 15:55:54.490593+00
158	157	158	OWNER	t	2026-11-24 15:55:54.490593+00
159	158	159	OWNER	t	2026-11-24 15:55:54.490593+00
160	159	160	OWNER	t	2026-11-24 15:55:54.490593+00
161	160	161	OWNER	t	2026-11-24 15:55:54.490593+00
162	161	162	OWNER	t	2026-11-24 15:55:54.490593+00
163	162	163	OWNER	t	2026-11-24 15:55:54.490593+00
164	163	164	OWNER	t	2026-11-24 15:55:54.490593+00
165	164	165	OWNER	t	2026-11-24 15:55:54.490593+00
166	165	166	OWNER	t	2026-11-24 15:55:54.490593+00
167	166	167	OWNER	t	2026-11-24 15:55:54.490593+00
168	167	168	OWNER	t	2026-11-24 15:55:54.490593+00
169	168	169	OWNER	t	2026-11-24 15:55:54.490593+00
170	169	170	OWNER	t	2026-11-24 15:55:54.490593+00
171	170	171	OWNER	t	2026-11-24 15:55:54.490593+00
172	171	172	OWNER	t	2026-11-24 15:55:54.490593+00
173	172	173	OWNER	t	2026-11-24 15:55:54.490593+00
174	173	174	OWNER	t	2026-11-24 15:55:54.490593+00
175	174	175	OWNER	t	2026-11-24 15:55:54.490593+00
176	175	176	OWNER	t	2026-11-24 15:55:54.490593+00
177	176	177	OWNER	t	2026-11-24 15:55:54.490593+00
178	177	178	OWNER	t	2026-11-24 15:55:54.490593+00
179	178	179	OWNER	t	2026-11-24 15:55:54.490593+00
180	179	180	OWNER	t	2026-11-24 15:55:54.490593+00
181	180	181	OWNER	t	2026-11-24 15:55:54.490593+00
182	181	182	OWNER	t	2026-11-24 15:55:54.490593+00
183	182	183	OWNER	t	2026-11-24 15:55:54.490593+00
184	183	184	OWNER	t	2026-11-24 15:55:54.490593+00
185	184	185	OWNER	t	2026-11-24 15:55:54.490593+00
186	185	186	OWNER	t	2026-11-24 15:55:54.490593+00
187	186	187	OWNER	t	2026-11-24 15:55:54.490593+00
188	187	188	OWNER	t	2026-11-24 15:55:54.490593+00
189	188	189	OWNER	t	2026-11-24 15:55:54.490593+00
190	189	190	OWNER	t	2026-11-24 15:55:54.490593+00
191	190	191	OWNER	t	2026-11-24 15:55:54.490593+00
192	191	192	OWNER	t	2026-11-24 15:55:54.490593+00
193	192	193	OWNER	t	2026-11-24 15:55:54.490593+00
194	193	194	OWNER	t	2026-11-24 15:55:54.490593+00
195	194	195	OWNER	t	2026-11-24 15:55:54.490593+00
196	195	196	OWNER	t	2026-11-24 15:55:54.490593+00
197	196	197	OWNER	t	2026-11-24 15:55:54.490593+00
198	197	198	OWNER	t	2026-11-24 15:55:54.490593+00
199	198	199	OWNER	t	2026-11-24 15:55:54.490593+00
200	199	200	OWNER	t	2026-11-24 15:55:54.490593+00
201	200	201	OWNER	t	2026-11-24 15:55:54.490593+00
202	201	202	OWNER	t	2026-11-24 15:55:54.490593+00
203	202	203	OWNER	t	2026-11-24 15:55:54.490593+00
204	203	204	OWNER	t	2026-11-24 15:55:54.490593+00
205	204	205	OWNER	t	2026-11-24 15:55:54.490593+00
206	205	206	OWNER	t	2026-11-24 15:55:54.490593+00
207	206	207	OWNER	t	2026-11-24 15:55:54.490593+00
208	207	208	OWNER	t	2026-11-24 15:55:54.490593+00
209	208	209	OWNER	t	2026-11-24 15:55:54.490593+00
210	209	210	OWNER	t	2026-11-24 15:55:54.490593+00
211	210	211	OWNER	t	2026-11-24 15:55:54.490593+00
212	211	212	OWNER	t	2026-11-24 15:55:54.490593+00
213	212	213	OWNER	t	2026-11-24 15:55:54.490593+00
214	213	214	OWNER	t	2026-11-24 15:55:54.490593+00
215	214	215	OWNER	t	2026-11-24 15:55:54.490593+00
216	215	216	OWNER	t	2026-11-24 15:55:54.490593+00
217	216	217	OWNER	t	2026-11-24 15:55:54.490593+00
218	217	218	OWNER	t	2026-11-24 15:55:54.490593+00
219	218	219	OWNER	t	2026-11-24 15:55:54.490593+00
220	219	220	OWNER	t	2026-11-24 15:55:54.490593+00
221	220	221	OWNER	t	2026-11-24 15:55:54.490593+00
222	221	222	OWNER	t	2026-11-24 15:55:54.490593+00
223	222	223	OWNER	t	2026-11-24 15:55:54.490593+00
224	223	224	OWNER	t	2026-11-24 15:55:54.490593+00
225	224	225	OWNER	t	2026-11-24 15:55:54.490593+00
226	225	226	OWNER	t	2026-11-24 15:55:54.490593+00
227	226	227	OWNER	t	2026-11-24 15:55:54.490593+00
228	227	228	OWNER	t	2026-11-24 15:55:54.490593+00
229	228	229	OWNER	t	2026-11-24 15:55:54.490593+00
230	229	230	OWNER	t	2026-11-24 15:55:54.490593+00
231	230	231	OWNER	t	2026-11-24 15:55:54.490593+00
232	231	232	OWNER	t	2026-11-24 15:55:54.490593+00
233	232	233	OWNER	t	2026-11-24 15:55:54.490593+00
234	233	234	OWNER	t	2026-11-24 15:55:54.490593+00
235	234	235	OWNER	t	2026-11-24 15:55:54.490593+00
236	235	236	OWNER	t	2026-11-24 15:55:54.490593+00
237	236	237	OWNER	t	2026-11-24 15:55:54.490593+00
238	237	238	OWNER	t	2026-11-24 15:55:54.490593+00
239	238	239	OWNER	t	2026-11-24 15:55:54.490593+00
240	239	240	OWNER	t	2026-11-24 15:55:54.490593+00
241	240	241	OWNER	t	2026-11-24 15:55:54.490593+00
242	241	242	OWNER	t	2026-11-24 15:55:54.490593+00
243	242	243	OWNER	t	2026-11-24 15:55:54.490593+00
244	1	244	MEMBER	t	2026-11-24 15:55:54.490593+00
245	1	245	MEMBER	t	2026-11-24 15:55:54.490593+00
246	1	246	MEMBER	t	2026-11-24 15:55:54.490593+00
247	1	247	MEMBER	t	2026-11-24 15:55:54.490593+00
248	1	248	MEMBER	t	2026-11-24 15:55:54.490593+00
249	1	249	MEMBER	t	2026-11-24 15:55:54.490593+00
250	1	250	MEMBER	t	2026-11-24 15:55:54.490593+00
251	1	251	MEMBER	t	2026-11-24 15:55:54.490593+00
252	1	252	MEMBER	t	2026-11-24 15:55:54.490593+00
253	1	253	MEMBER	t	2026-11-24 15:55:54.490593+00
254	243	254	OWNER	t	2026-11-24 16:52:44.889941+00
255	244	255	OWNER	t	2026-11-24 16:55:50.898203+00
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.organizations (id, legal_name, display_name, organization_type, registration_number, tax_id, email, phone, address_line1, address_line2, city, state, postal_code, country, verification_status, created_at, updated_at) FROM stdin;
1	ForgeTrace Platform	ForgeTrace	PLATFORM	\N	\N	\N	\N	\N	\N	\N	\N	\N	India	VERIFIED	2026-11-24 11:36:22.281099+00	2026-11-24 11:36:22.281099+00
2	Webmints	Webmints	MANUFACTURER	\N	\N	yakshpanchal.dev@gmail.com	\N	\N	\N	\N	\N	\N	India	VERIFIED	2026-11-24 13:09:38.43768+00	2026-11-24 13:09:38.43768+00
3	Shree Precision Components LLP	Shree Precision Components	MANUFACTURER	U25037242001PTC104513	24AABBM1071D1Z2	mfr001@demo.forgetrace.in	+91 9800007919	Plot 4, GIDC Estate	\N	Vadodara	Gujarat	390010	India	VERIFIED	2026-11-21 15:55:54.490593+00	2026-11-23 15:55:54.490593+00
4	Om Castings Industries	Om Castings	MANUFACTURER	U25074362002PTC109026	36AABCM1142G1Z3	mfr002@demo.forgetrace.in	+91 9800015838	Plot 7, SIDCO Industrial Estate	\N	Hyderabad	Telangana	500078	India	VERIFIED	2026-11-18 15:55:54.490593+00	2026-11-22 15:55:54.490593+00
5	Unique Forgings Pvt Ltd	Unique Forgings	MANUFACTURER	U25111232003PTC113539	23AABDM1213J1Z4	mfr003@demo.forgetrace.in	+91 9800023757	Plot 10, Industrial Area Phase 2	\N	Indore	Madhya Pradesh	452015	India	VERIFIED	2026-11-15 15:55:54.490593+00	2026-11-21 15:55:54.490593+00
6	Trident Sheet Metal Enterprises	Trident Sheet Metal	MANUFACTURER	U25148272004PTC118052	27AABEM1284M1Z5	mfr004@demo.forgetrace.in	+91 9800031676	Plot 13, Focal Point	\N	Aurangabad	Maharashtra	431136	India	VERIFIED	2026-11-12 15:55:54.490593+00	2026-11-20 15:55:54.490593+00
7	Vishwa Polymers Pvt Ltd	Vishwa Polymers	MANUFACTURER	U25185332005PTC122565	33AABFM1355P1Z6	mfr005@demo.forgetrace.in	+91 9800039595	Plot 16, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-11-09 15:55:54.490593+00	2026-11-19 15:55:54.490593+00
8	Mahalaxmi Die Casting LLP	Mahalaxmi Die Casting	MANUFACTURER	U25222062006PTC127078	06AABGM1426S1Z7	mfr006@demo.forgetrace.in	+91 9800047514	Plot 19, Udyog Vihar	\N	Faridabad	Haryana	121005	India	VERIFIED	2026-11-06 15:55:54.490593+00	2026-11-18 15:55:54.490593+00
9	Shakti Engineering Works Industries	Shakti Engineering Works	MANUFACTURER	U25259372007PTC131591	37AABHM1497V1Z8	mfr007@demo.forgetrace.in	+91 9800055433	Plot 22, Peenya Industrial Area	\N	Visakhapatnam	Andhra Pradesh	530012	India	VERIFIED	2026-11-03 15:55:54.490593+00	2026-11-17 15:55:54.490593+00
10	Krishna Auto Parts Pvt Ltd	Krishna Auto Parts	MANUFACTURER	U25296242008PTC136104	24AABIM1568Y1Z9	mfr008@demo.forgetrace.in	+91 9800063352	Plot 25, Sector 24	\N	Ahmedabad	Gujarat	382445	India	VERIFIED	2026-10-31 15:55:54.490593+00	2026-11-16 15:55:54.490593+00
11	Sterling Fabricators Enterprises	Sterling Fabricators	MANUFACTURER	U25333292009PTC140617	29AABJM1639B1Z1	mfr009@demo.forgetrace.in	+91 9800071271	Plot 28, Special Economic Zone	\N	Mysuru	Karnataka	570016	India	VERIFIED	2026-10-28 15:55:54.490593+00	2026-11-15 15:55:54.490593+00
12	Excel Tooling Pvt Ltd	Excel Tooling	MANUFACTURER	U25370082010PTC145130	08AABKM1710E1Z2	mfr010@demo.forgetrace.in	+91 9800079190	Plot 31, MIDC Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-10-25 15:55:54.490593+00	2026-11-14 15:55:54.490593+00
13	Sai Precision Components LLP	Sai Precision Components	MANUFACTURER	U25407272011PTC149643	27AABLM1781H1Z3	mfr011@demo.forgetrace.in	+91 9800087109	Plot 34, GIDC Estate	\N	Nashik	Maharashtra	422007	India	VERIFIED	2026-10-22 15:55:54.490593+00	2026-11-13 15:55:54.490593+00
14	Jai Castings Industries	Jai Castings	MANUFACTURER	U25444332012PTC154156	33AABMM1852K1Z4	mfr012@demo.forgetrace.in	+91 9800095028	Plot 37, SIDCO Industrial Estate	\N	Chennai	Tamil Nadu	600058	India	VERIFIED	2026-10-19 15:55:54.490593+00	2026-11-12 15:55:54.490593+00
15	Precision Forgings Pvt Ltd	Precision Forgings	MANUFACTURER	U25481032013PTC158669	03AABNM1923N1Z5	mfr013@demo.forgetrace.in	+91 9800102947	Plot 40, Industrial Area Phase 2	\N	Mohali	Punjab	160055	India	VERIFIED	2026-10-16 15:55:54.490593+00	2026-11-11 15:55:54.490593+00
16	Apex Sheet Metal Enterprises	Apex Sheet Metal	MANUFACTURER	U25518202014PTC163182	20AABOM1994Q1Z6	mfr014@demo.forgetrace.in	+91 9800110866	Plot 43, Focal Point	\N	Jamshedpur	Jharkhand	831013	India	VERIFIED	2026-10-13 15:55:54.490593+00	2026-11-10 15:55:54.490593+00
17	Navkar Polymers Pvt Ltd	Navkar Polymers	MANUFACTURER	U25555242015PTC167695	24AABPM2065T1Z7	mfr015@demo.forgetrace.in	+91 9800118785	Plot 46, SIPCOT	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-10-10 15:55:54.490593+00	2026-11-09 15:55:54.490593+00
18	Ganesh Die Casting LLP	Ganesh Die Casting	MANUFACTURER	U25592292016PTC172208	29AABQM2136W1Z8	mfr016@demo.forgetrace.in	+91 9800126704	Plot 49, Udyog Vihar	\N	Bengaluru	Karnataka	560058	India	VERIFIED	2026-10-07 15:55:54.490593+00	2026-11-08 15:55:54.490593+00
19	Royal Engineering Works Industries	Royal Engineering Works	MANUFACTURER	U25629092017PTC176721	09AABRM2207Z1Z9	mfr017@demo.forgetrace.in	+91 9800134623	Plot 52, Peenya Industrial Area	\N	Noida	Uttar Pradesh	201301	India	VERIFIED	2026-10-04 15:55:54.490593+00	2026-11-07 15:55:54.490593+00
20	Siddhi Auto Parts Pvt Ltd	Siddhi Auto Parts	MANUFACTURER	U25666272018PTC181234	27AABSM2278C1Z1	mfr018@demo.forgetrace.in	+91 9800142542	Plot 55, Sector 24	\N	Mumbai	Maharashtra	400093	India	VERIFIED	2026-10-01 15:55:54.490593+00	2026-11-06 15:55:54.490593+00
21	National Fabricators Enterprises	National Fabricators	MANUFACTURER	U25703242019PTC185747	24AABTM2349F1Z2	mfr019@demo.forgetrace.in	+91 9800150461	Plot 58, Special Economic Zone	\N	Surat	Gujarat	394210	India	VERIFIED	2026-09-28 15:55:54.490593+00	2026-11-05 15:55:54.490593+00
22	Global Tooling Pvt Ltd	Global Tooling	MANUFACTURER	U25740032020PTC190260	03AABUM2420I1Z3	mfr020@demo.forgetrace.in	+91 9800158380	Plot 61, MIDC Industrial Area	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-09-25 15:55:54.490593+00	2026-11-04 15:55:54.490593+00
23	Bharat Precision Components LLP	Bharat Precision Components	MANUFACTURER	U25777192021PTC194773	19AABVM2491L1Z4	mfr021@demo.forgetrace.in	+91 9800166299	Plot 64, GIDC Estate	\N	Kolkata	West Bengal	700091	India	VERIFIED	2026-09-22 15:55:54.490593+00	2026-11-03 15:55:54.490593+00
24	Pragati Castings Industries	Pragati Castings	MANUFACTURER	U25814272022PTC199286	27AABWM2562O1Z5	mfr022@demo.forgetrace.in	+91 9800174218	Plot 67, SIDCO Industrial Estate	\N	Kolhapur	Maharashtra	416122	India	VERIFIED	2026-09-19 15:55:54.490593+00	2026-11-02 15:55:54.490593+00
25	Galaxy Forgings Pvt Ltd	Galaxy Forgings	MANUFACTURER	U25851332023PTC203799	33AABXM2633R1Z6	mfr023@demo.forgetrace.in	+91 9800182137	Plot 70, Industrial Area Phase 2	\N	Hosur	Tamil Nadu	635126	India	VERIFIED	2026-09-16 15:55:54.490593+00	2026-11-01 15:55:54.490593+00
26	Prime Sheet Metal Enterprises	Prime Sheet Metal	MANUFACTURER	U25888062024PTC208312	06AABYM2704U1Z7	mfr024@demo.forgetrace.in	+91 9800190056	Plot 73, Focal Point	\N	Gurugram	Haryana	122015	India	VERIFIED	2026-09-13 15:55:54.490593+00	2026-10-31 15:55:54.490593+00
27	Swastik Polymers Pvt Ltd	Swastik Polymers	MANUFACTURER	U25925272000PTC212825	27AABZM2775X1Z8	mfr025@demo.forgetrace.in	+91 9800197975	Plot 76, SIPCOT	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-09-10 15:55:54.490593+00	2026-10-30 15:55:54.490593+00
28	Ambica Die Casting LLP	Ambica Die Casting	MANUFACTURER	U25962242001PTC217338	24AABAM2846A1Z9	mfr026@demo.forgetrace.in	+91 9800205894	Plot 79, Udyog Vihar	\N	Vadodara	Gujarat	390010	India	VERIFIED	2026-09-07 15:55:54.490593+00	2026-10-29 15:55:54.490593+00
29	Supreme Engineering Works Industries	Supreme Engineering Works	MANUFACTURER	U25999362002PTC221851	36AABBM2917D1Z1	mfr027@demo.forgetrace.in	+91 9800213813	Plot 82, Peenya Industrial Area	\N	Hyderabad	Telangana	500078	India	VERIFIED	2026-09-04 15:55:54.490593+00	2026-10-28 15:55:54.490593+00
30	Venkatesh Auto Parts Pvt Ltd	Venkatesh Auto Parts	MANUFACTURER	U26036232003PTC226364	23AABCM2988G1Z2	mfr028@demo.forgetrace.in	+91 9800221732	Plot 85, Sector 24	\N	Indore	Madhya Pradesh	452015	India	VERIFIED	2026-09-01 15:55:54.490593+00	2026-10-27 15:55:54.490593+00
31	Modern Fabricators Enterprises	Modern Fabricators	MANUFACTURER	U26073272004PTC230877	27AABDM3059J1Z3	mfr029@demo.forgetrace.in	+91 9800229651	Plot 88, Special Economic Zone	\N	Aurangabad	Maharashtra	431136	India	VERIFIED	2026-08-29 15:55:54.490593+00	2026-10-26 15:55:54.490593+00
32	Arihant Tooling Pvt Ltd	Arihant Tooling	MANUFACTURER	U26110332005PTC235390	33AABEM3130M1Z4	mfr030@demo.forgetrace.in	+91 9800237570	Plot 91, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-08-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
33	Om Precision Components LLP	Om Precision Components	MANUFACTURER	U26147062006PTC239903	06AABFM3201P1Z5	mfr031@demo.forgetrace.in	+91 9800245489	Plot 94, GIDC Estate	\N	Faridabad	Haryana	121005	India	VERIFIED	2026-08-23 15:55:54.490593+00	2026-11-23 15:55:54.490593+00
34	Unique Castings Industries	Unique Castings	MANUFACTURER	U26184372007PTC244416	37AABGM3272S1Z6	mfr032@demo.forgetrace.in	+91 9800253408	Plot 97, SIDCO Industrial Estate	\N	Visakhapatnam	Andhra Pradesh	530012	India	VERIFIED	2026-08-20 15:55:54.490593+00	2026-11-22 15:55:54.490593+00
35	Trident Forgings Pvt Ltd	Trident Forgings	MANUFACTURER	U26221242008PTC248929	24AABHM3343V1Z7	mfr033@demo.forgetrace.in	+91 9800261327	Plot 100, Industrial Area Phase 2	\N	Ahmedabad	Gujarat	382445	India	VERIFIED	2026-08-17 15:55:54.490593+00	2026-11-21 15:55:54.490593+00
36	Vishwa Sheet Metal Enterprises	Vishwa Sheet Metal	MANUFACTURER	U26258292009PTC253442	29AABIM3414Y1Z8	mfr034@demo.forgetrace.in	+91 9800269246	Plot 103, Focal Point	\N	Mysuru	Karnataka	570016	India	VERIFIED	2026-08-14 15:55:54.490593+00	2026-11-20 15:55:54.490593+00
37	Mahalaxmi Polymers Pvt Ltd	Mahalaxmi Polymers	MANUFACTURER	U26295082010PTC257955	08AABJM3485B1Z9	mfr035@demo.forgetrace.in	+91 9800277165	Plot 106, SIPCOT	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-08-11 15:55:54.490593+00	2026-11-19 15:55:54.490593+00
38	Shakti Die Casting LLP	Shakti Die Casting	MANUFACTURER	U26332272011PTC262468	27AABKM3556E1Z1	mfr036@demo.forgetrace.in	+91 9800285084	Plot 109, Udyog Vihar	\N	Nashik	Maharashtra	422007	India	VERIFIED	2026-08-08 15:55:54.490593+00	2026-11-18 15:55:54.490593+00
39	Krishna Engineering Works Industries	Krishna Engineering Works	MANUFACTURER	U26369332012PTC266981	33AABLM3627H1Z2	mfr037@demo.forgetrace.in	+91 9800293003	Plot 112, Peenya Industrial Area	\N	Chennai	Tamil Nadu	600058	India	VERIFIED	2026-08-05 15:55:54.490593+00	2026-11-17 15:55:54.490593+00
40	Sterling Auto Parts Pvt Ltd	Sterling Auto Parts	MANUFACTURER	U26406032013PTC271494	03AABMM3698K1Z3	mfr038@demo.forgetrace.in	+91 9800300922	Plot 115, Sector 24	\N	Mohali	Punjab	160055	India	VERIFIED	2026-08-02 15:55:54.490593+00	2026-11-16 15:55:54.490593+00
41	Excel Fabricators Enterprises	Excel Fabricators	MANUFACTURER	U26443202014PTC276007	20AABNM3769N1Z4	mfr039@demo.forgetrace.in	+91 9800308841	Plot 118, Special Economic Zone	\N	Jamshedpur	Jharkhand	831013	India	VERIFIED	2026-07-30 15:55:54.490593+00	2026-11-15 15:55:54.490593+00
42	Shree Tooling Pvt Ltd	Shree Tooling	MANUFACTURER	U26480242015PTC280520	24AABOM3840Q1Z5	mfr040@demo.forgetrace.in	+91 9800316760	Plot 121, MIDC Industrial Area	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-07-27 15:55:54.490593+00	2026-11-14 15:55:54.490593+00
43	Jai Precision Components LLP	Jai Precision Components	MANUFACTURER	U26517292016PTC285033	29AABPM3911T1Z6	mfr041@demo.forgetrace.in	+91 9800324679	Plot 124, GIDC Estate	\N	Bengaluru	Karnataka	560058	India	VERIFIED	2026-07-24 15:55:54.490593+00	2026-11-13 15:55:54.490593+00
44	Precision Castings Industries	Precision Castings	MANUFACTURER	U26554092017PTC289546	09AABQM3982W1Z7	mfr042@demo.forgetrace.in	+91 9800332598	Plot 127, SIDCO Industrial Estate	\N	Noida	Uttar Pradesh	201301	India	VERIFIED	2026-07-21 15:55:54.490593+00	2026-11-12 15:55:54.490593+00
45	Apex Forgings Pvt Ltd	Apex Forgings	MANUFACTURER	U26591272018PTC294059	27AABRM4053Z1Z8	mfr043@demo.forgetrace.in	+91 9800340517	Plot 130, Industrial Area Phase 2	\N	Mumbai	Maharashtra	400093	India	VERIFIED	2026-07-18 15:55:54.490593+00	2026-11-11 15:55:54.490593+00
46	Navkar Sheet Metal Enterprises	Navkar Sheet Metal	MANUFACTURER	U26628242019PTC298572	24AABSM4124C1Z9	mfr044@demo.forgetrace.in	+91 9800348436	Plot 133, Focal Point	\N	Surat	Gujarat	394210	India	VERIFIED	2026-07-15 15:55:54.490593+00	2026-11-10 15:55:54.490593+00
47	Ganesh Polymers Pvt Ltd	Ganesh Polymers	MANUFACTURER	U26665032020PTC303085	03AABTM4195F1Z1	mfr045@demo.forgetrace.in	+91 9800356355	Plot 136, SIPCOT	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-07-12 15:55:54.490593+00	2026-11-09 15:55:54.490593+00
48	Royal Die Casting LLP	Royal Die Casting	MANUFACTURER	U26702192021PTC307598	19AABUM4266I1Z2	mfr046@demo.forgetrace.in	+91 9800364274	Plot 139, Udyog Vihar	\N	Kolkata	West Bengal	700091	India	VERIFIED	2026-07-09 15:55:54.490593+00	2026-11-08 15:55:54.490593+00
49	Siddhi Engineering Works Industries	Siddhi Engineering Works	MANUFACTURER	U26739272022PTC312111	27AABVM4337L1Z3	mfr047@demo.forgetrace.in	+91 9800372193	Plot 142, Peenya Industrial Area	\N	Kolhapur	Maharashtra	416122	India	VERIFIED	2026-07-06 15:55:54.490593+00	2026-11-07 15:55:54.490593+00
50	National Auto Parts Pvt Ltd	National Auto Parts	MANUFACTURER	U26776332023PTC316624	33AABWM4408O1Z4	mfr048@demo.forgetrace.in	+91 9800380112	Plot 145, Sector 24	\N	Hosur	Tamil Nadu	635126	India	VERIFIED	2026-07-03 15:55:54.490593+00	2026-11-06 15:55:54.490593+00
51	Global Fabricators Enterprises	Global Fabricators	MANUFACTURER	U26813062024PTC321137	06AABXM4479R1Z5	mfr049@demo.forgetrace.in	+91 9800388031	Plot 148, Special Economic Zone	\N	Gurugram	Haryana	122015	India	VERIFIED	2026-06-30 15:55:54.490593+00	2026-11-05 15:55:54.490593+00
52	Sai Tooling Pvt Ltd	Sai Tooling	MANUFACTURER	U26850272000PTC325650	27AABYM4550U1Z6	mfr050@demo.forgetrace.in	+91 9800395950	Plot 151, MIDC Industrial Area	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-06-27 15:55:54.490593+00	2026-11-04 15:55:54.490593+00
53	Pragati Precision Components LLP	Pragati Precision Components	MANUFACTURER	U26887242001PTC330163	24AABZM4621X1Z7	mfr051@demo.forgetrace.in	+91 9800403869	Plot 154, GIDC Estate	\N	Vadodara	Gujarat	390010	India	VERIFIED	2026-06-24 15:55:54.490593+00	2026-11-03 15:55:54.490593+00
54	Galaxy Castings Industries	Galaxy Castings	MANUFACTURER	U26924362002PTC334676	36AABAM4692A1Z8	mfr052@demo.forgetrace.in	+91 9800411788	Plot 157, SIDCO Industrial Estate	\N	Hyderabad	Telangana	500078	India	VERIFIED	2026-06-21 15:55:54.490593+00	2026-11-02 15:55:54.490593+00
55	Prime Forgings Pvt Ltd	Prime Forgings	MANUFACTURER	U26961232003PTC339189	23AABBM4763D1Z9	mfr053@demo.forgetrace.in	+91 9800419707	Plot 160, Industrial Area Phase 2	\N	Indore	Madhya Pradesh	452015	India	VERIFIED	2026-06-18 15:55:54.490593+00	2026-11-01 15:55:54.490593+00
56	Swastik Sheet Metal Enterprises	Swastik Sheet Metal	MANUFACTURER	U26998272004PTC343702	27AABCM4834G1Z1	mfr054@demo.forgetrace.in	+91 9800427626	Plot 163, Focal Point	\N	Aurangabad	Maharashtra	431136	India	VERIFIED	2026-06-15 15:55:54.490593+00	2026-10-31 15:55:54.490593+00
57	Ambica Polymers Pvt Ltd	Ambica Polymers	MANUFACTURER	U27035332005PTC348215	33AABDM4905J1Z2	mfr055@demo.forgetrace.in	+91 9800435545	Plot 166, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-06-12 15:55:54.490593+00	2026-10-30 15:55:54.490593+00
58	Supreme Die Casting LLP	Supreme Die Casting	MANUFACTURER	U27072062006PTC352728	06AABEM4976M1Z3	mfr056@demo.forgetrace.in	+91 9800443464	Plot 169, Udyog Vihar	\N	Faridabad	Haryana	121005	India	VERIFIED	2026-06-09 15:55:54.490593+00	2026-10-29 15:55:54.490593+00
59	Venkatesh Engineering Works Industries	Venkatesh Engineering Works	MANUFACTURER	U27109372007PTC357241	37AABFM5047P1Z4	mfr057@demo.forgetrace.in	+91 9800451383	Plot 172, Peenya Industrial Area	\N	Visakhapatnam	Andhra Pradesh	530012	India	VERIFIED	2026-06-06 15:55:54.490593+00	2026-10-28 15:55:54.490593+00
60	Modern Auto Parts Pvt Ltd	Modern Auto Parts	MANUFACTURER	U27146242008PTC361754	24AABGM5118S1Z5	mfr058@demo.forgetrace.in	+91 9800459302	Plot 175, Sector 24	\N	Ahmedabad	Gujarat	382445	India	VERIFIED	2026-06-03 15:55:54.490593+00	2026-10-27 15:55:54.490593+00
61	Arihant Fabricators Enterprises	Arihant Fabricators	MANUFACTURER	U27183292009PTC366267	29AABHM5189V1Z6	mfr059@demo.forgetrace.in	+91 9800467221	Plot 178, Special Economic Zone	\N	Mysuru	Karnataka	570016	India	VERIFIED	2026-05-31 15:55:54.490593+00	2026-10-26 15:55:54.490593+00
62	Bharat Tooling Pvt Ltd	Bharat Tooling	MANUFACTURER	U27220082010PTC370780	08AABIM5260Y1Z7	mfr060@demo.forgetrace.in	+91 9800475140	Plot 181, MIDC Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-05-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
63	Unique Precision Components LLP	Unique Precision Components	MANUFACTURER	U27257272011PTC375293	27AABJM5331B1Z8	mfr061@demo.forgetrace.in	+91 9800483059	Plot 184, GIDC Estate	\N	Nashik	Maharashtra	422007	India	VERIFIED	2026-05-25 15:55:54.490593+00	2026-11-23 15:55:54.490593+00
64	Trident Castings Industries	Trident Castings	MANUFACTURER	U27294332012PTC379806	33AABKM5402E1Z9	mfr062@demo.forgetrace.in	+91 9800490978	Plot 187, SIDCO Industrial Estate	\N	Chennai	Tamil Nadu	600058	India	VERIFIED	2026-05-22 15:55:54.490593+00	2026-11-22 15:55:54.490593+00
65	Vishwa Forgings Pvt Ltd	Vishwa Forgings	MANUFACTURER	U27331032013PTC384319	03AABLM5473H1Z1	mfr063@demo.forgetrace.in	+91 9800498897	Plot 190, Industrial Area Phase 2	\N	Mohali	Punjab	160055	India	VERIFIED	2026-05-19 15:55:54.490593+00	2026-11-21 15:55:54.490593+00
66	Mahalaxmi Sheet Metal Enterprises	Mahalaxmi Sheet Metal	MANUFACTURER	U27368202014PTC388832	20AABMM5544K1Z2	mfr064@demo.forgetrace.in	+91 9800506816	Plot 193, Focal Point	\N	Jamshedpur	Jharkhand	831013	India	VERIFIED	2026-05-16 15:55:54.490593+00	2026-11-20 15:55:54.490593+00
67	Shakti Polymers Pvt Ltd	Shakti Polymers	MANUFACTURER	U27405242015PTC393345	24AABNM5615N1Z3	mfr065@demo.forgetrace.in	+91 9800514735	Plot 196, SIPCOT	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-05-13 15:55:54.490593+00	2026-11-19 15:55:54.490593+00
68	Krishna Die Casting LLP	Krishna Die Casting	MANUFACTURER	U27442292016PTC397858	29AABOM5686Q1Z4	mfr066@demo.forgetrace.in	+91 9800522654	Plot 199, Udyog Vihar	\N	Bengaluru	Karnataka	560058	India	VERIFIED	2026-05-10 15:55:54.490593+00	2026-11-18 15:55:54.490593+00
69	Sterling Engineering Works Industries	Sterling Engineering Works	MANUFACTURER	U27479092017PTC402371	09AABPM5757T1Z5	mfr067@demo.forgetrace.in	+91 9800530573	Plot 2, Peenya Industrial Area	\N	Noida	Uttar Pradesh	201301	India	VERIFIED	2026-05-07 15:55:54.490593+00	2026-11-17 15:55:54.490593+00
70	Excel Auto Parts Pvt Ltd	Excel Auto Parts	MANUFACTURER	U27516272018PTC406884	27AABQM5828W1Z6	mfr068@demo.forgetrace.in	+91 9800538492	Plot 5, Sector 24	\N	Mumbai	Maharashtra	400093	India	VERIFIED	2026-05-04 15:55:54.490593+00	2026-11-16 15:55:54.490593+00
71	Shree Fabricators Enterprises	Shree Fabricators	MANUFACTURER	U27553242019PTC411397	24AABRM5899Z1Z7	mfr069@demo.forgetrace.in	+91 9800546411	Plot 8, Special Economic Zone	\N	Surat	Gujarat	394210	India	VERIFIED	2026-05-01 15:55:54.490593+00	2026-11-15 15:55:54.490593+00
72	Om Tooling Pvt Ltd	Om Tooling	MANUFACTURER	U27590032020PTC415910	03AABSM5970C1Z8	mfr070@demo.forgetrace.in	+91 9800554330	Plot 11, MIDC Industrial Area	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-04-28 15:55:54.490593+00	2026-11-14 15:55:54.490593+00
73	Precision Precision Components LLP	Precision Precision Components	MANUFACTURER	U27627192021PTC420423	19AABTM6041F1Z9	mfr071@demo.forgetrace.in	+91 9800562249	Plot 14, GIDC Estate	\N	Kolkata	West Bengal	700091	India	VERIFIED	2026-04-25 15:55:54.490593+00	2026-11-13 15:55:54.490593+00
74	Apex Castings Industries	Apex Castings	MANUFACTURER	U27664272022PTC424936	27AABUM6112I1Z1	mfr072@demo.forgetrace.in	+91 9800570168	Plot 17, SIDCO Industrial Estate	\N	Kolhapur	Maharashtra	416122	India	VERIFIED	2026-04-22 15:55:54.490593+00	2026-11-12 15:55:54.490593+00
75	Navkar Forgings Pvt Ltd	Navkar Forgings	MANUFACTURER	U27701332023PTC429449	33AABVM6183L1Z2	mfr073@demo.forgetrace.in	+91 9800578087	Plot 20, Industrial Area Phase 2	\N	Hosur	Tamil Nadu	635126	India	VERIFIED	2026-04-19 15:55:54.490593+00	2026-11-11 15:55:54.490593+00
76	Ganesh Sheet Metal Enterprises	Ganesh Sheet Metal	MANUFACTURER	U27738062024PTC433962	06AABWM6254O1Z3	mfr074@demo.forgetrace.in	+91 9800586006	Plot 23, Focal Point	\N	Gurugram	Haryana	122015	India	VERIFIED	2026-04-16 15:55:54.490593+00	2026-11-10 15:55:54.490593+00
77	Royal Polymers Pvt Ltd	Royal Polymers	MANUFACTURER	U27775272000PTC438475	27AABXM6325R1Z4	mfr075@demo.forgetrace.in	+91 9800593925	Plot 26, SIPCOT	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-04-13 15:55:54.490593+00	2026-11-09 15:55:54.490593+00
78	Siddhi Die Casting LLP	Siddhi Die Casting	MANUFACTURER	U27812242001PTC442988	24AABYM6396U1Z5	mfr076@demo.forgetrace.in	+91 9800601844	Plot 29, Udyog Vihar	\N	Vadodara	Gujarat	390010	India	VERIFIED	2026-04-10 15:55:54.490593+00	2026-11-08 15:55:54.490593+00
79	National Engineering Works Industries	National Engineering Works	MANUFACTURER	U27849362002PTC447501	36AABZM6467X1Z6	mfr077@demo.forgetrace.in	+91 9800609763	Plot 32, Peenya Industrial Area	\N	Hyderabad	Telangana	500078	India	VERIFIED	2026-04-07 15:55:54.490593+00	2026-11-07 15:55:54.490593+00
80	Global Auto Parts Pvt Ltd	Global Auto Parts	MANUFACTURER	U27886232003PTC452014	23AABAM6538A1Z7	mfr078@demo.forgetrace.in	+91 9800617682	Plot 35, Sector 24	\N	Indore	Madhya Pradesh	452015	India	VERIFIED	2026-04-04 15:55:54.490593+00	2026-11-06 15:55:54.490593+00
81	Sai Fabricators Enterprises	Sai Fabricators	MANUFACTURER	U27923272004PTC456527	27AABBM6609D1Z8	mfr079@demo.forgetrace.in	+91 9800625601	Plot 38, Special Economic Zone	\N	Aurangabad	Maharashtra	431136	India	VERIFIED	2026-04-01 15:55:54.490593+00	2026-11-05 15:55:54.490593+00
82	Jai Tooling Pvt Ltd	Jai Tooling	MANUFACTURER	U27960332005PTC461040	33AABCM6680G1Z9	mfr080@demo.forgetrace.in	+91 9800633520	Plot 41, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-03-29 15:55:54.490593+00	2026-11-04 15:55:54.490593+00
83	Galaxy Precision Components LLP	Galaxy Precision Components	MANUFACTURER	U27997062006PTC465553	06AABDM6751J1Z1	mfr081@demo.forgetrace.in	+91 9800641439	Plot 44, GIDC Estate	\N	Faridabad	Haryana	121005	India	VERIFIED	2026-03-26 15:55:54.490593+00	2026-11-03 15:55:54.490593+00
84	Prime Castings Industries	Prime Castings	MANUFACTURER	U28034372007PTC470066	37AABEM6822M1Z2	mfr082@demo.forgetrace.in	+91 9800649358	Plot 47, SIDCO Industrial Estate	\N	Visakhapatnam	Andhra Pradesh	530012	India	VERIFIED	2026-03-23 15:55:54.490593+00	2026-11-02 15:55:54.490593+00
85	Swastik Forgings Pvt Ltd	Swastik Forgings	MANUFACTURER	U28071242008PTC474579	24AABFM6893P1Z3	mfr083@demo.forgetrace.in	+91 9800657277	Plot 50, Industrial Area Phase 2	\N	Ahmedabad	Gujarat	382445	India	VERIFIED	2026-03-20 15:55:54.490593+00	2026-11-01 15:55:54.490593+00
86	Ambica Sheet Metal Enterprises	Ambica Sheet Metal	MANUFACTURER	U28108292009PTC479092	29AABGM6964S1Z4	mfr084@demo.forgetrace.in	+91 9800665196	Plot 53, Focal Point	\N	Mysuru	Karnataka	570016	India	VERIFIED	2026-03-17 15:55:54.490593+00	2026-10-31 15:55:54.490593+00
87	Supreme Polymers Pvt Ltd	Supreme Polymers	MANUFACTURER	U28145082010PTC483605	08AABHM7035V1Z5	mfr085@demo.forgetrace.in	+91 9800673115	Plot 56, SIPCOT	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-03-14 15:55:54.490593+00	2026-10-30 15:55:54.490593+00
88	Venkatesh Die Casting LLP	Venkatesh Die Casting	MANUFACTURER	U28182272011PTC488118	27AABIM7106Y1Z6	mfr086@demo.forgetrace.in	+91 9800681034	Plot 59, Udyog Vihar	\N	Nashik	Maharashtra	422007	India	VERIFIED	2026-03-11 15:55:54.490593+00	2026-10-29 15:55:54.490593+00
89	Modern Engineering Works Industries	Modern Engineering Works	MANUFACTURER	U28219332012PTC492631	33AABJM7177B1Z7	mfr087@demo.forgetrace.in	+91 9800688953	Plot 62, Peenya Industrial Area	\N	Chennai	Tamil Nadu	600058	India	VERIFIED	2026-03-08 15:55:54.490593+00	2026-10-28 15:55:54.490593+00
90	Arihant Auto Parts Pvt Ltd	Arihant Auto Parts	MANUFACTURER	U28256032013PTC497144	03AABKM7248E1Z8	mfr088@demo.forgetrace.in	+91 9800696872	Plot 65, Sector 24	\N	Mohali	Punjab	160055	India	VERIFIED	2026-03-05 15:55:54.490593+00	2026-10-27 15:55:54.490593+00
91	Bharat Fabricators Enterprises	Bharat Fabricators	MANUFACTURER	U28293202014PTC501657	20AABLM7319H1Z9	mfr089@demo.forgetrace.in	+91 9800704791	Plot 68, Special Economic Zone	\N	Jamshedpur	Jharkhand	831013	India	VERIFIED	2026-03-02 15:55:54.490593+00	2026-10-26 15:55:54.490593+00
92	Pragati Tooling Pvt Ltd	Pragati Tooling	MANUFACTURER	U28330242015PTC506170	24AABMM7390K1Z1	mfr090@demo.forgetrace.in	+91 9800712710	Plot 71, MIDC Industrial Area	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-02-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
93	Trident Precision Components LLP	Trident Precision Components	MANUFACTURER	U28367292016PTC510683	29AABNM7461N1Z2	mfr091@demo.forgetrace.in	+91 9800720629	Plot 74, GIDC Estate	\N	Bengaluru	Karnataka	560058	India	VERIFIED	2026-02-24 15:55:54.490593+00	2026-11-23 15:55:54.490593+00
94	Vishwa Castings Industries	Vishwa Castings	MANUFACTURER	U28404092017PTC515196	09AABOM7532Q1Z3	mfr092@demo.forgetrace.in	+91 9800728548	Plot 77, SIDCO Industrial Estate	\N	Noida	Uttar Pradesh	201301	India	VERIFIED	2026-02-21 15:55:54.490593+00	2026-11-22 15:55:54.490593+00
95	Mahalaxmi Forgings Pvt Ltd	Mahalaxmi Forgings	MANUFACTURER	U28441272018PTC519709	27AABPM7603T1Z4	mfr093@demo.forgetrace.in	+91 9800736467	Plot 80, Industrial Area Phase 2	\N	Mumbai	Maharashtra	400093	India	VERIFIED	2026-02-18 15:55:54.490593+00	2026-11-21 15:55:54.490593+00
96	Shakti Sheet Metal Enterprises	Shakti Sheet Metal	MANUFACTURER	U28478242019PTC524222	24AABQM7674W1Z5	mfr094@demo.forgetrace.in	+91 9800744386	Plot 83, Focal Point	\N	Surat	Gujarat	394210	India	VERIFIED	2026-02-15 15:55:54.490593+00	2026-11-20 15:55:54.490593+00
97	Krishna Polymers Pvt Ltd	Krishna Polymers	MANUFACTURER	U28515032020PTC528735	03AABRM7745Z1Z6	mfr095@demo.forgetrace.in	+91 9800752305	Plot 86, SIPCOT	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-02-12 15:55:54.490593+00	2026-11-19 15:55:54.490593+00
98	Sterling Die Casting LLP	Sterling Die Casting	MANUFACTURER	U28552192021PTC533248	19AABSM7816C1Z7	mfr096@demo.forgetrace.in	+91 9800760224	Plot 89, Udyog Vihar	\N	Kolkata	West Bengal	700091	India	VERIFIED	2026-02-09 15:55:54.490593+00	2026-11-18 15:55:54.490593+00
99	Excel Engineering Works Industries	Excel Engineering Works	MANUFACTURER	U28589272022PTC537761	27AABTM7887F1Z8	mfr097@demo.forgetrace.in	+91 9800768143	Plot 92, Peenya Industrial Area	\N	Kolhapur	Maharashtra	416122	India	VERIFIED	2026-02-06 15:55:54.490593+00	2026-11-17 15:55:54.490593+00
100	Shree Auto Parts Pvt Ltd	Shree Auto Parts	MANUFACTURER	U28626332023PTC542274	33AABUM7958I1Z9	mfr098@demo.forgetrace.in	+91 9800776062	Plot 95, Sector 24	\N	Hosur	Tamil Nadu	635126	India	VERIFIED	2026-02-03 15:55:54.490593+00	2026-11-16 15:55:54.490593+00
101	Om Fabricators Enterprises	Om Fabricators	MANUFACTURER	U28663062024PTC546787	06AABVM8029L1Z1	mfr099@demo.forgetrace.in	+91 9800783981	Plot 98, Special Economic Zone	\N	Gurugram	Haryana	122015	India	VERIFIED	2026-01-31 15:55:54.490593+00	2026-11-15 15:55:54.490593+00
102	Unique Tooling Pvt Ltd	Unique Tooling	MANUFACTURER	U28700272000PTC551300	27AABWM8100O1Z2	mfr100@demo.forgetrace.in	+91 9800791900	Plot 101, MIDC Industrial Area	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-01-28 15:55:54.490593+00	2026-11-14 15:55:54.490593+00
103	Apex Precision Components LLP	Apex Precision Components	MANUFACTURER	U28737242001PTC555813	24AABXM8171R1Z3	mfr101@demo.forgetrace.in	+91 9800799819	Plot 104, GIDC Estate	\N	Vadodara	Gujarat	390010	India	PENDING	2026-01-25 15:55:54.490593+00	2026-11-13 15:55:54.490593+00
104	Navkar Castings Industries	Navkar Castings	MANUFACTURER	U28774362002PTC560326	36AABYM8242U1Z4	mfr102@demo.forgetrace.in	+91 9800807738	Plot 107, SIDCO Industrial Estate	\N	Hyderabad	Telangana	500078	India	PENDING	2026-01-22 15:55:54.490593+00	2026-11-12 15:55:54.490593+00
105	Ganesh Forgings Pvt Ltd	Ganesh Forgings	MANUFACTURER	U28811232003PTC564839	23AABZM8313X1Z5	mfr103@demo.forgetrace.in	+91 9800815657	Plot 110, Industrial Area Phase 2	\N	Indore	Madhya Pradesh	452015	India	PENDING	2026-01-19 15:55:54.490593+00	2026-11-11 15:55:54.490593+00
106	Royal Sheet Metal Enterprises	Royal Sheet Metal	MANUFACTURER	U28848272004PTC569352	27AABAM8384A1Z6	mfr104@demo.forgetrace.in	+91 9800823576	Plot 113, Focal Point	\N	Aurangabad	Maharashtra	431136	India	PENDING	2026-01-16 15:55:54.490593+00	2026-11-10 15:55:54.490593+00
107	Siddhi Polymers Pvt Ltd	Siddhi Polymers	MANUFACTURER	U28885332005PTC573865	33AABBM8455D1Z7	mfr105@demo.forgetrace.in	+91 9800831495	Plot 116, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	PENDING	2026-01-13 15:55:54.490593+00	2026-11-09 15:55:54.490593+00
108	National Die Casting LLP	National Die Casting	MANUFACTURER	U28922062006PTC578378	06AABCM8526G1Z8	mfr106@demo.forgetrace.in	+91 9800839414	Plot 119, Udyog Vihar	\N	Faridabad	Haryana	121005	India	PENDING	2026-01-10 15:55:54.490593+00	2026-11-08 15:55:54.490593+00
109	Global Engineering Works Industries	Global Engineering Works	MANUFACTURER	U28959372007PTC582891	37AABDM8597J1Z9	mfr107@demo.forgetrace.in	+91 9800847333	Plot 122, Peenya Industrial Area	\N	Visakhapatnam	Andhra Pradesh	530012	India	PENDING	2026-01-07 15:55:54.490593+00	2026-11-07 15:55:54.490593+00
110	Sai Auto Parts Pvt Ltd	Sai Auto Parts	MANUFACTURER	U28996242008PTC587404	24AABEM8668M1Z1	mfr108@demo.forgetrace.in	+91 9800855252	Plot 125, Sector 24	\N	Ahmedabad	Gujarat	382445	India	PENDING	2026-01-04 15:55:54.490593+00	2026-11-06 15:55:54.490593+00
111	Jai Fabricators Enterprises	Jai Fabricators	MANUFACTURER	U29033292009PTC591917	29AABFM8739P1Z2	mfr109@demo.forgetrace.in	+91 9800863171	Plot 128, Special Economic Zone	\N	Mysuru	Karnataka	570016	India	PENDING	2026-01-01 15:55:54.490593+00	2026-11-05 15:55:54.490593+00
112	Precision Tooling Pvt Ltd	Precision Tooling	MANUFACTURER	U29070082010PTC596430	08AABGM8810S1Z3	mfr110@demo.forgetrace.in	+91 9800871090	Plot 131, MIDC Industrial Area	\N	Jaipur	Rajasthan	302022	India	PENDING	2025-12-29 15:55:54.490593+00	2026-11-04 15:55:54.490593+00
113	Prime Precision Components LLP	Prime Precision Components	MANUFACTURER	U29107272011PTC600943	27AABHM8881V1Z4	mfr111@demo.forgetrace.in	+91 9800879009	Plot 134, GIDC Estate	\N	Nashik	Maharashtra	422007	India	PENDING	2025-12-26 15:55:54.490593+00	2026-11-03 15:55:54.490593+00
114	Swastik Castings Industries	Swastik Castings	MANUFACTURER	U29144332012PTC605456	33AABIM8952Y1Z5	mfr112@demo.forgetrace.in	+91 9800886928	Plot 137, SIDCO Industrial Estate	\N	Chennai	Tamil Nadu	600058	India	PENDING	2025-12-23 15:55:54.490593+00	2026-11-02 15:55:54.490593+00
115	Ambica Forgings Pvt Ltd	Ambica Forgings	MANUFACTURER	U29181032013PTC609969	03AABJM9023B1Z6	mfr113@demo.forgetrace.in	+91 9800894847	Plot 140, Industrial Area Phase 2	\N	Mohali	Punjab	160055	India	PENDING	2025-12-20 15:55:54.490593+00	2026-11-01 15:55:54.490593+00
116	Supreme Sheet Metal Enterprises	Supreme Sheet Metal	MANUFACTURER	U29218202014PTC614482	20AABKM9094E1Z7	mfr114@demo.forgetrace.in	+91 9800902766	Plot 143, Focal Point	\N	Jamshedpur	Jharkhand	831013	India	PENDING	2025-12-17 15:55:54.490593+00	2026-10-31 15:55:54.490593+00
117	Venkatesh Polymers Pvt Ltd	Venkatesh Polymers	MANUFACTURER	U29255242015PTC618995	24AABLM9165H1Z8	mfr115@demo.forgetrace.in	+91 9800910685	Plot 146, SIPCOT	\N	Rajkot	Gujarat	360021	India	PENDING	2025-12-14 15:55:54.490593+00	2026-10-30 15:55:54.490593+00
118	Modern Die Casting LLP	Modern Die Casting	MANUFACTURER	U29292292016PTC623508	29AABMM9236K1Z9	mfr116@demo.forgetrace.in	+91 9800918604	Plot 149, Udyog Vihar	\N	Bengaluru	Karnataka	560058	India	REJECTED	2025-12-11 15:55:54.490593+00	2026-10-29 15:55:54.490593+00
119	Arihant Engineering Works Industries	Arihant Engineering Works	MANUFACTURER	U29329092017PTC628021	09AABNM9307N1Z1	mfr117@demo.forgetrace.in	+91 9800926523	Plot 152, Peenya Industrial Area	\N	Noida	Uttar Pradesh	201301	India	REJECTED	2025-12-08 15:55:54.490593+00	2026-10-28 15:55:54.490593+00
120	Bharat Auto Parts Pvt Ltd	Bharat Auto Parts	MANUFACTURER	U29366272018PTC632534	27AABOM9378Q1Z2	mfr118@demo.forgetrace.in	+91 9800934442	Plot 155, Sector 24	\N	Mumbai	Maharashtra	400093	India	REJECTED	2025-12-05 15:55:54.490593+00	2026-10-27 15:55:54.490593+00
121	Pragati Fabricators Enterprises	Pragati Fabricators	MANUFACTURER	U29403242019PTC637047	24AABPM9449T1Z3	mfr119@demo.forgetrace.in	+91 9800942361	Plot 158, Special Economic Zone	\N	Surat	Gujarat	394210	India	REJECTED	2025-12-02 15:55:54.490593+00	2026-10-26 15:55:54.490593+00
122	Galaxy Tooling Pvt Ltd	Galaxy Tooling	MANUFACTURER	U29440032020PTC641560	03AABQM9520W1Z4	mfr120@demo.forgetrace.in	+91 9800950280	Plot 161, MIDC Industrial Area	\N	Ludhiana	Punjab	141010	India	REJECTED	2025-11-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
123	Voltix Tractors Pvt Ltd	Voltix Tractors	BUYER	\N	24AACBB2053F1Z2	buyer001@demo.forgetrace.in	+91 8700006151	Unit 2, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-11-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
124	AgroDrive Pumps Pvt Ltd	AgroDrive Pumps	BUYER	\N	33AACCB2106K1Z3	buyer002@demo.forgetrace.in	+91 8700012302	Unit 3, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-11-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
125	AquaFlow Devices Pvt Ltd	AquaFlow Devices	BUYER	\N	03AACDB2159P1Z4	buyer003@demo.forgetrace.in	+91 8700018453	Unit 4, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
126	Medisure Drones LLP	Medisure Drones	BUYER	\N	08AACEB2212U1Z5	buyer004@demo.forgetrace.in	+91 8700024604	Unit 5, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-11-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
127	SkyNest Machines Pvt Ltd	SkyNest Machines	BUYER	\N	27AACFB2265Z1Z6	buyer005@demo.forgetrace.in	+91 8700030755	Unit 6, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-11-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
128	Konkan Solar Pvt Ltd	Konkan Solar	BUYER	\N	24AACGB2318E1Z7	buyer006@demo.forgetrace.in	+91 8700036906	Unit 7, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-11-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
129	GreenGrid Components Pvt Ltd	GreenGrid Components	BUYER	\N	33AACHB2371J1Z8	buyer007@demo.forgetrace.in	+91 8700043057	Unit 8, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-11-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
130	Railtech Appliances LLP	Railtech Appliances	BUYER	\N	03AACIB2424O1Z9	buyer008@demo.forgetrace.in	+91 8700049208	Unit 9, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-11-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
131	HomeKraft Robotics Pvt Ltd	HomeKraft Robotics	BUYER	\N	08AACJB2477T1Z1	buyer009@demo.forgetrace.in	+91 8700055359	Unit 10, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-11-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
132	Ignite Mobility Pvt Ltd	Ignite Mobility	BUYER	\N	27AACKB2530Y1Z2	buyer010@demo.forgetrace.in	+91 8700061510	Unit 11, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-11-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
133	Zenith Tractors Pvt Ltd	Zenith Tractors	BUYER	\N	24AACLB2583D1Z3	buyer011@demo.forgetrace.in	+91 8700067661	Unit 12, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-11-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
134	Orbit Pumps LLP	Orbit Pumps	BUYER	\N	33AACMB2636I1Z4	buyer012@demo.forgetrace.in	+91 8700073812	Unit 13, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
135	NovaTech Devices Pvt Ltd	NovaTech Devices	BUYER	\N	03AACNB2689N1Z5	buyer013@demo.forgetrace.in	+91 8700079963	Unit 14, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-10-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
136	BlueRiver Drones Pvt Ltd	BlueRiver Drones	BUYER	\N	08AACOB2742S1Z6	buyer014@demo.forgetrace.in	+91 8700086114	Unit 15, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-10-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
137	Sunrise Machines Pvt Ltd	Sunrise Machines	BUYER	\N	27AACPB2795X1Z7	buyer015@demo.forgetrace.in	+91 8700092265	Unit 16, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-10-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
138	IronLeaf Solar LLP	IronLeaf Solar	BUYER	\N	24AACQB2848C1Z8	buyer016@demo.forgetrace.in	+91 8700098416	Unit 17, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-10-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
139	Quantum Components Pvt Ltd	Quantum Components	BUYER	\N	33AACRB2901H1Z9	buyer017@demo.forgetrace.in	+91 8700104567	Unit 18, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-10-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
140	Vega Appliances Pvt Ltd	Vega Appliances	BUYER	\N	03AACSB2954M1Z1	buyer018@demo.forgetrace.in	+91 8700110718	Unit 19, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-10-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
141	Helix Robotics Pvt Ltd	Helix Robotics	BUYER	\N	08AACTB3007R1Z2	buyer019@demo.forgetrace.in	+91 8700116869	Unit 20, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-10-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
142	Terra Mobility LLP	Terra Mobility	BUYER	\N	27AACUB3060W1Z3	buyer020@demo.forgetrace.in	+91 8700123020	Unit 21, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-10-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
143	Voltix Pumps Pvt Ltd	Voltix Pumps	BUYER	\N	24AACVB3113B1Z4	buyer021@demo.forgetrace.in	+91 8700129171	Unit 22, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
144	AgroDrive Devices Pvt Ltd	AgroDrive Devices	BUYER	\N	33AACWB3166G1Z5	buyer022@demo.forgetrace.in	+91 8700135322	Unit 23, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-10-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
145	AquaFlow Drones Pvt Ltd	AquaFlow Drones	BUYER	\N	03AACXB3219L1Z6	buyer023@demo.forgetrace.in	+91 8700141473	Unit 24, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-10-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
146	Medisure Machines LLP	Medisure Machines	BUYER	\N	08AACYB3272Q1Z7	buyer024@demo.forgetrace.in	+91 8700147624	Unit 25, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-10-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
147	SkyNest Solar Pvt Ltd	SkyNest Solar	BUYER	\N	27AACZB3325V1Z8	buyer025@demo.forgetrace.in	+91 8700153775	Unit 26, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-10-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
148	Konkan Components Pvt Ltd	Konkan Components	BUYER	\N	24AACAB3378A1Z9	buyer026@demo.forgetrace.in	+91 8700159926	Unit 27, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-10-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
149	GreenGrid Appliances Pvt Ltd	GreenGrid Appliances	BUYER	\N	33AACBB3431F1Z1	buyer027@demo.forgetrace.in	+91 8700166077	Unit 28, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-10-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
150	Railtech Robotics LLP	Railtech Robotics	BUYER	\N	03AACCB3484K1Z2	buyer028@demo.forgetrace.in	+91 8700172228	Unit 29, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-09-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
151	HomeKraft Mobility Pvt Ltd	HomeKraft Mobility	BUYER	\N	08AACDB3537P1Z3	buyer029@demo.forgetrace.in	+91 8700178379	Unit 30, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-09-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
152	Ignite Tractors Pvt Ltd	Ignite Tractors	BUYER	\N	27AACEB3590U1Z4	buyer030@demo.forgetrace.in	+91 8700184530	Unit 31, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
153	Zenith Pumps Pvt Ltd	Zenith Pumps	BUYER	\N	24AACFB3643Z1Z5	buyer031@demo.forgetrace.in	+91 8700190681	Unit 32, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-09-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
154	Orbit Devices LLP	Orbit Devices	BUYER	\N	33AACGB3696E1Z6	buyer032@demo.forgetrace.in	+91 8700196832	Unit 33, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-09-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
155	NovaTech Drones Pvt Ltd	NovaTech Drones	BUYER	\N	03AACHB3749J1Z7	buyer033@demo.forgetrace.in	+91 8700202983	Unit 34, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-09-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
156	BlueRiver Machines Pvt Ltd	BlueRiver Machines	BUYER	\N	08AACIB3802O1Z8	buyer034@demo.forgetrace.in	+91 8700209134	Unit 35, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-09-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
157	Sunrise Solar Pvt Ltd	Sunrise Solar	BUYER	\N	27AACJB3855T1Z9	buyer035@demo.forgetrace.in	+91 8700215285	Unit 36, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-09-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
158	IronLeaf Components LLP	IronLeaf Components	BUYER	\N	24AACKB3908Y1Z1	buyer036@demo.forgetrace.in	+91 8700221436	Unit 37, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-09-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
159	Quantum Appliances Pvt Ltd	Quantum Appliances	BUYER	\N	33AACLB3961D1Z2	buyer037@demo.forgetrace.in	+91 8700227587	Unit 38, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-09-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
160	Vega Robotics Pvt Ltd	Vega Robotics	BUYER	\N	03AACMB4014I1Z3	buyer038@demo.forgetrace.in	+91 8700233738	Unit 39, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-09-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
161	Helix Mobility Pvt Ltd	Helix Mobility	BUYER	\N	08AACNB4067N1Z4	buyer039@demo.forgetrace.in	+91 8700239889	Unit 40, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
162	Terra Tractors LLP	Terra Tractors	BUYER	\N	27AACOB4120S1Z5	buyer040@demo.forgetrace.in	+91 8700246040	Unit 41, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-09-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
163	Voltix Devices Pvt Ltd	Voltix Devices	BUYER	\N	24AACPB4173X1Z6	buyer041@demo.forgetrace.in	+91 8700252191	Unit 42, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-09-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
164	AgroDrive Drones Pvt Ltd	AgroDrive Drones	BUYER	\N	33AACQB4226C1Z7	buyer042@demo.forgetrace.in	+91 8700258342	Unit 43, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-09-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
165	AquaFlow Machines Pvt Ltd	AquaFlow Machines	BUYER	\N	03AACRB4279H1Z8	buyer043@demo.forgetrace.in	+91 8700264493	Unit 44, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-08-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
166	Medisure Solar LLP	Medisure Solar	BUYER	\N	08AACSB4332M1Z9	buyer044@demo.forgetrace.in	+91 8700270644	Unit 45, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-08-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
167	SkyNest Components Pvt Ltd	SkyNest Components	BUYER	\N	27AACTB4385R1Z1	buyer045@demo.forgetrace.in	+91 8700276795	Unit 46, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-08-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
168	Konkan Appliances Pvt Ltd	Konkan Appliances	BUYER	\N	24AACUB4438W1Z2	buyer046@demo.forgetrace.in	+91 8700282946	Unit 47, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-08-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
169	GreenGrid Robotics Pvt Ltd	GreenGrid Robotics	BUYER	\N	33AACVB4491B1Z3	buyer047@demo.forgetrace.in	+91 8700289097	Unit 48, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-08-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
170	Railtech Mobility LLP	Railtech Mobility	BUYER	\N	03AACWB4544G1Z4	buyer048@demo.forgetrace.in	+91 8700295248	Unit 49, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
171	HomeKraft Tractors Pvt Ltd	HomeKraft Tractors	BUYER	\N	08AACXB4597L1Z5	buyer049@demo.forgetrace.in	+91 8700301399	Unit 50, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-08-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
172	Ignite Pumps Pvt Ltd	Ignite Pumps	BUYER	\N	27AACYB4650Q1Z6	buyer050@demo.forgetrace.in	+91 8700307550	Unit 51, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-08-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
173	Zenith Devices Pvt Ltd	Zenith Devices	BUYER	\N	24AACZB4703V1Z7	buyer051@demo.forgetrace.in	+91 8700313701	Unit 52, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-08-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
174	Orbit Drones LLP	Orbit Drones	BUYER	\N	33AACAB4756A1Z8	buyer052@demo.forgetrace.in	+91 8700319852	Unit 53, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-08-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
175	NovaTech Machines Pvt Ltd	NovaTech Machines	BUYER	\N	03AACBB4809F1Z9	buyer053@demo.forgetrace.in	+91 8700326003	Unit 54, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-08-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
176	BlueRiver Solar Pvt Ltd	BlueRiver Solar	BUYER	\N	08AACCB4862K1Z1	buyer054@demo.forgetrace.in	+91 8700332154	Unit 55, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-08-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
177	Sunrise Components Pvt Ltd	Sunrise Components	BUYER	\N	27AACDB4915P1Z2	buyer055@demo.forgetrace.in	+91 8700338305	Unit 56, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-08-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
178	IronLeaf Appliances LLP	IronLeaf Appliances	BUYER	\N	24AACEB4968U1Z3	buyer056@demo.forgetrace.in	+91 8700344456	Unit 57, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-08-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
179	Quantum Robotics Pvt Ltd	Quantum Robotics	BUYER	\N	33AACFB5021Z1Z4	buyer057@demo.forgetrace.in	+91 8700350607	Unit 58, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
180	Vega Mobility Pvt Ltd	Vega Mobility	BUYER	\N	03AACGB5074E1Z5	buyer058@demo.forgetrace.in	+91 8700356758	Unit 59, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-07-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
181	Helix Tractors Pvt Ltd	Helix Tractors	BUYER	\N	08AACHB5127J1Z6	buyer059@demo.forgetrace.in	+91 8700362909	Unit 60, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-07-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
182	Terra Pumps LLP	Terra Pumps	BUYER	\N	27AACIB5180O1Z7	buyer060@demo.forgetrace.in	+91 8700369060	Unit 61, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-07-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
183	Voltix Drones Pvt Ltd	Voltix Drones	BUYER	\N	24AACJB5233T1Z8	buyer061@demo.forgetrace.in	+91 8700375211	Unit 62, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-07-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
184	AgroDrive Machines Pvt Ltd	AgroDrive Machines	BUYER	\N	33AACKB5286Y1Z9	buyer062@demo.forgetrace.in	+91 8700381362	Unit 63, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-07-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
185	AquaFlow Solar Pvt Ltd	AquaFlow Solar	BUYER	\N	03AACLB5339D1Z1	buyer063@demo.forgetrace.in	+91 8700387513	Unit 64, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-07-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
186	Medisure Components LLP	Medisure Components	BUYER	\N	08AACMB5392I1Z2	buyer064@demo.forgetrace.in	+91 8700393664	Unit 65, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-07-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
187	SkyNest Appliances Pvt Ltd	SkyNest Appliances	BUYER	\N	27AACNB5445N1Z3	buyer065@demo.forgetrace.in	+91 8700399815	Unit 66, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-07-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
188	Konkan Robotics Pvt Ltd	Konkan Robotics	BUYER	\N	24AACOB5498S1Z4	buyer066@demo.forgetrace.in	+91 8700405966	Unit 67, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
189	GreenGrid Mobility Pvt Ltd	GreenGrid Mobility	BUYER	\N	33AACPB5551X1Z5	buyer067@demo.forgetrace.in	+91 8700412117	Unit 68, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-07-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
190	Railtech Tractors LLP	Railtech Tractors	BUYER	\N	03AACQB5604C1Z6	buyer068@demo.forgetrace.in	+91 8700418268	Unit 69, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-07-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
191	HomeKraft Pumps Pvt Ltd	HomeKraft Pumps	BUYER	\N	08AACRB5657H1Z7	buyer069@demo.forgetrace.in	+91 8700424419	Unit 70, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-07-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
192	Ignite Devices Pvt Ltd	Ignite Devices	BUYER	\N	27AACSB5710M1Z8	buyer070@demo.forgetrace.in	+91 8700430570	Unit 71, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-07-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
193	Zenith Drones Pvt Ltd	Zenith Drones	BUYER	\N	24AACTB5763R1Z9	buyer071@demo.forgetrace.in	+91 8700436721	Unit 72, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-07-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
194	Orbit Machines LLP	Orbit Machines	BUYER	\N	33AACUB5816W1Z1	buyer072@demo.forgetrace.in	+91 8700442872	Unit 73, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-07-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
195	NovaTech Solar Pvt Ltd	NovaTech Solar	BUYER	\N	03AACVB5869B1Z2	buyer073@demo.forgetrace.in	+91 8700449023	Unit 74, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-07-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
196	BlueRiver Components Pvt Ltd	BlueRiver Components	BUYER	\N	08AACWB5922G1Z3	buyer074@demo.forgetrace.in	+91 8700455174	Unit 75, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-06-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
197	Sunrise Appliances Pvt Ltd	Sunrise Appliances	BUYER	\N	27AACXB5975L1Z4	buyer075@demo.forgetrace.in	+91 8700461325	Unit 76, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
198	IronLeaf Robotics LLP	IronLeaf Robotics	BUYER	\N	24AACYB6028Q1Z5	buyer076@demo.forgetrace.in	+91 8700467476	Unit 77, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-06-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
199	Quantum Mobility Pvt Ltd	Quantum Mobility	BUYER	\N	33AACZB6081V1Z6	buyer077@demo.forgetrace.in	+91 8700473627	Unit 78, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-06-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
200	Vega Tractors Pvt Ltd	Vega Tractors	BUYER	\N	03AACAB6134A1Z7	buyer078@demo.forgetrace.in	+91 8700479778	Unit 79, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-06-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
201	Helix Pumps Pvt Ltd	Helix Pumps	BUYER	\N	08AACBB6187F1Z8	buyer079@demo.forgetrace.in	+91 8700485929	Unit 80, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-06-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
202	Terra Devices LLP	Terra Devices	BUYER	\N	27AACCB6240K1Z9	buyer080@demo.forgetrace.in	+91 8700492080	Unit 81, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-06-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
203	Voltix Machines Pvt Ltd	Voltix Machines	BUYER	\N	24AACDB6293P1Z1	buyer081@demo.forgetrace.in	+91 8700498231	Unit 82, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-06-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
204	AgroDrive Solar Pvt Ltd	AgroDrive Solar	BUYER	\N	33AACEB6346U1Z2	buyer082@demo.forgetrace.in	+91 8700504382	Unit 83, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-06-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
205	AquaFlow Components Pvt Ltd	AquaFlow Components	BUYER	\N	03AACFB6399Z1Z3	buyer083@demo.forgetrace.in	+91 8700510533	Unit 84, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-06-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
206	Medisure Appliances LLP	Medisure Appliances	BUYER	\N	08AACGB6452E1Z4	buyer084@demo.forgetrace.in	+91 8700516684	Unit 85, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
207	SkyNest Robotics Pvt Ltd	SkyNest Robotics	BUYER	\N	27AACHB6505J1Z5	buyer085@demo.forgetrace.in	+91 8700522835	Unit 86, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-06-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
208	Konkan Mobility Pvt Ltd	Konkan Mobility	BUYER	\N	24AACIB6558O1Z6	buyer086@demo.forgetrace.in	+91 8700528986	Unit 87, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-06-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
209	GreenGrid Tractors Pvt Ltd	GreenGrid Tractors	BUYER	\N	33AACJB6611T1Z7	buyer087@demo.forgetrace.in	+91 8700535137	Unit 88, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-06-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
210	Railtech Pumps LLP	Railtech Pumps	BUYER	\N	03AACKB6664Y1Z8	buyer088@demo.forgetrace.in	+91 8700541288	Unit 89, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-06-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
211	HomeKraft Devices Pvt Ltd	HomeKraft Devices	BUYER	\N	08AACLB6717D1Z9	buyer089@demo.forgetrace.in	+91 8700547439	Unit 90, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-05-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
212	Ignite Drones Pvt Ltd	Ignite Drones	BUYER	\N	27AACMB6770I1Z1	buyer090@demo.forgetrace.in	+91 8700553590	Unit 1, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-05-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
213	Zenith Machines Pvt Ltd	Zenith Machines	BUYER	\N	24AACNB6823N1Z2	buyer091@demo.forgetrace.in	+91 8700559741	Unit 2, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-05-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
214	Orbit Solar LLP	Orbit Solar	BUYER	\N	33AACOB6876S1Z3	buyer092@demo.forgetrace.in	+91 8700565892	Unit 3, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-05-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
215	NovaTech Components Pvt Ltd	NovaTech Components	BUYER	\N	03AACPB6929X1Z4	buyer093@demo.forgetrace.in	+91 8700572043	Unit 4, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
216	BlueRiver Appliances Pvt Ltd	BlueRiver Appliances	BUYER	\N	08AACQB6982C1Z5	buyer094@demo.forgetrace.in	+91 8700578194	Unit 5, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-05-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
217	Sunrise Robotics Pvt Ltd	Sunrise Robotics	BUYER	\N	27AACRB7035H1Z6	buyer095@demo.forgetrace.in	+91 8700584345	Unit 6, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-05-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
218	IronLeaf Mobility LLP	IronLeaf Mobility	BUYER	\N	24AACSB7088M1Z7	buyer096@demo.forgetrace.in	+91 8700590496	Unit 7, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-05-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
219	Quantum Tractors Pvt Ltd	Quantum Tractors	BUYER	\N	33AACTB7141R1Z8	buyer097@demo.forgetrace.in	+91 8700596647	Unit 8, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-05-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
220	Vega Pumps Pvt Ltd	Vega Pumps	BUYER	\N	03AACUB7194W1Z9	buyer098@demo.forgetrace.in	+91 8700602798	Unit 9, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-05-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
221	Helix Devices Pvt Ltd	Helix Devices	BUYER	\N	08AACVB7247B1Z1	buyer099@demo.forgetrace.in	+91 8700608949	Unit 10, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-05-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
222	Terra Drones LLP	Terra Drones	BUYER	\N	27AACWB7300G1Z2	buyer100@demo.forgetrace.in	+91 8700615100	Unit 11, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-05-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
223	Voltix Solar Pvt Ltd	Voltix Solar	BUYER	\N	24AACXB7353L1Z3	buyer101@demo.forgetrace.in	+91 8700621251	Unit 12, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-05-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
224	AgroDrive Components Pvt Ltd	AgroDrive Components	BUYER	\N	33AACYB7406Q1Z4	buyer102@demo.forgetrace.in	+91 8700627402	Unit 13, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
225	AquaFlow Appliances Pvt Ltd	AquaFlow Appliances	BUYER	\N	03AACZB7459V1Z5	buyer103@demo.forgetrace.in	+91 8700633553	Unit 14, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-05-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
226	Medisure Robotics LLP	Medisure Robotics	BUYER	\N	08AACAB7512A1Z6	buyer104@demo.forgetrace.in	+91 8700639704	Unit 15, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-04-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
227	SkyNest Mobility Pvt Ltd	SkyNest Mobility	BUYER	\N	27AACBB7565F1Z7	buyer105@demo.forgetrace.in	+91 8700645855	Unit 16, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-04-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
228	Konkan Tractors Pvt Ltd	Konkan Tractors	BUYER	\N	24AACCB7618K1Z8	buyer106@demo.forgetrace.in	+91 8700652006	Unit 17, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-04-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
229	GreenGrid Pumps Pvt Ltd	GreenGrid Pumps	BUYER	\N	33AACDB7671P1Z9	buyer107@demo.forgetrace.in	+91 8700658157	Unit 18, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-04-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
230	Railtech Devices LLP	Railtech Devices	BUYER	\N	03AACEB7724U1Z1	buyer108@demo.forgetrace.in	+91 8700664308	Unit 19, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-04-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
231	HomeKraft Drones Pvt Ltd	HomeKraft Drones	BUYER	\N	08AACFB7777Z1Z2	buyer109@demo.forgetrace.in	+91 8700670459	Unit 20, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-04-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
232	Ignite Machines Pvt Ltd	Ignite Machines	BUYER	\N	27AACGB7830E1Z3	buyer110@demo.forgetrace.in	+91 8700676610	Unit 21, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-04-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
233	Zenith Solar Pvt Ltd	Zenith Solar	BUYER	\N	24AACHB7883J1Z4	buyer111@demo.forgetrace.in	+91 8700682761	Unit 22, Focal Point	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
234	Orbit Components LLP	Orbit Components	BUYER	\N	33AACIB7936O1Z5	buyer112@demo.forgetrace.in	+91 8700688912	Unit 23, SIPCOT	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-04-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
235	NovaTech Appliances Pvt Ltd	NovaTech Appliances	BUYER	\N	03AACJB7989T1Z6	buyer113@demo.forgetrace.in	+91 8700695063	Unit 24, Udyog Vihar	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-04-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
236	BlueRiver Robotics Pvt Ltd	BlueRiver Robotics	BUYER	\N	08AACKB8042Y1Z7	buyer114@demo.forgetrace.in	+91 8700701214	Unit 25, Peenya Industrial Area	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-04-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
237	Sunrise Mobility Pvt Ltd	Sunrise Mobility	BUYER	\N	27AACLB8095D1Z8	buyer115@demo.forgetrace.in	+91 8700707365	Unit 26, Sector 24	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-04-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
238	IronLeaf Tractors LLP	IronLeaf Tractors	BUYER	\N	24AACMB8148I1Z9	buyer116@demo.forgetrace.in	+91 8700713516	Unit 27, Special Economic Zone	\N	Rajkot	Gujarat	360021	India	VERIFIED	2026-04-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
239	Quantum Pumps Pvt Ltd	Quantum Pumps	BUYER	\N	33AACNB8201N1Z1	buyer117@demo.forgetrace.in	+91 8700719667	Unit 28, MIDC Industrial Area	\N	Coimbatore	Tamil Nadu	641021	India	VERIFIED	2026-04-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
240	Vega Devices Pvt Ltd	Vega Devices	BUYER	\N	03AACOB8254S1Z2	buyer118@demo.forgetrace.in	+91 8700725818	Unit 29, GIDC Estate	\N	Ludhiana	Punjab	141010	India	VERIFIED	2026-04-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
241	Helix Drones Pvt Ltd	Helix Drones	BUYER	\N	08AACPB8307X1Z3	buyer119@demo.forgetrace.in	+91 8700731969	Unit 30, SIDCO Industrial Estate	\N	Jaipur	Rajasthan	302022	India	VERIFIED	2026-03-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
242	Terra Machines LLP	Terra Machines	BUYER	\N	27AACQB8360C1Z4	buyer120@demo.forgetrace.in	+91 8700738120	Unit 31, Industrial Area Phase 2	\N	Pune	Maharashtra	411026	India	VERIFIED	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
243	GreenVolt Energy Pvt Ltd	GreenVolt Energy Pvt Ltd	BUYER	\N	\N	priya@greenvolt.test	+91 98200 11223	\N	\N	Pune	Maharashtra	\N	India	VERIFIED	2026-11-24 16:52:44.878945+00	2026-11-24 16:52:44.878945+00
244	Patil Fabrication Works Pvt Ltd	Patil Fabrication Works Pvt Ltd	MANUFACTURER	U28100MH2012PTC234567	27AAFCP5678L1Z2	rajesh@patilfab.test	+91 98900 44556	\N	\N	Pune	Maharashtra	\N	India	VERIFIED	2026-11-24 16:55:50.886231+00	2026-11-24 17:00:34.564889+00
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (id, user_id, token_hash, expires_at, used_at, created_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payments (id, production_order_id, payment_reference, provider, provider_reference, idempotency_key, amount, currency, payment_method, status, failure_reason, paid_at, created_at, updated_at) FROM stdin;
1	9	PAY-2026-D000009	SANDBOX	sbx_203EB5FDE9DBF8	7c31dd57-dbfc-40cd-9831-e700439d9280	2070274.60	INR	UPI	SUCCEEDED	\N	2026-11-24 13:28:26.706815+00	2026-11-24 13:28:26.706815+00	2026-11-24 13:28:26.706815+00
2	10	PAY-2026-D000010	SANDBOX	sbx_6C28A8CFBFAA62	edb120ab-b2a8-4f9a-af7f-508b1ba09a94	95447.25	INR	CARD	SUCCEEDED	\N	2026-11-23 00:28:26.706815+00	2026-11-23 00:28:26.706815+00	2026-11-23 00:28:26.706815+00
3	11	PAY-2026-D000011	SANDBOX	sbx_E004BC10C1821B	9f357c71-638a-4161-bb75-0f9cb60307fc	349949.65	INR	WALLET	SUCCEEDED	\N	2026-11-21 11:28:26.706815+00	2026-11-21 11:28:26.706815+00	2026-11-21 11:28:26.706815+00
4	12	PAY-2026-D005012	SANDBOX	\N	d72b6984-0231-4322-973b-de15ae3cbfb2	2289341.60	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-19 22:08:26.706815+00	2026-11-19 22:08:26.706815+00
5	12	PAY-2026-D000012	SANDBOX	sbx_7E2423742FAB90	132a8ba4-67d2-4076-a88c-3e6c8f20f599	2289341.60	INR	CARD	SUCCEEDED	\N	2026-11-19 22:28:26.706815+00	2026-11-19 22:28:26.706815+00	2026-11-19 22:28:26.706815+00
6	13	PAY-2026-D000013	SANDBOX	sbx_5E685CD212E533	a0f0e664-9fd5-4ac7-981b-32787e6f5406	9930939.00	INR	UPI	SUCCEEDED	\N	2026-11-18 09:28:26.706815+00	2026-11-18 09:28:26.706815+00	2026-11-18 09:28:26.706815+00
7	14	PAY-2026-D000014	SANDBOX	sbx_1578216FFD7952	7b82d35b-aa4e-49e7-86e7-52511a6f8013	393968.96	INR	NET_BANKING	SUCCEEDED	\N	2026-11-16 20:28:26.706815+00	2026-11-16 20:28:26.706815+00	2026-11-16 20:28:26.706815+00
8	15	PAY-2026-D000015	SANDBOX	sbx_37459FAAC78370	fc238003-0c66-4975-9a38-68a5ba03c615	265272.85	INR	UPI	SUCCEEDED	\N	2026-11-15 07:28:26.706815+00	2026-11-15 07:28:26.706815+00	2026-11-15 07:28:26.706815+00
9	16	PAY-2026-D005016	SANDBOX	\N	67c1451f-3898-4765-9b38-e241124b447b	998067.60	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-13 18:08:26.706815+00	2026-11-13 18:08:26.706815+00
10	16	PAY-2026-D000016	SANDBOX	sbx_39FDC80F5F4588	63c5118e-19ea-4ec8-9ef6-831d8ab5df93	998067.60	INR	CARD	SUCCEEDED	\N	2026-11-13 18:28:26.706815+00	2026-11-13 18:28:26.706815+00	2026-11-13 18:28:26.706815+00
11	17	PAY-2026-D000017	SANDBOX	sbx_CE2AF5F1279A46	d6a57fa6-52be-4dba-a7bf-f9eff8199069	85703.40	INR	WALLET	SUCCEEDED	\N	2026-11-12 05:28:26.706815+00	2026-11-12 05:28:26.706815+00	2026-11-12 05:28:26.706815+00
12	18	PAY-2026-D000018	SANDBOX	sbx_671BD8D0AC9474	5468c3aa-8727-4ae0-a93c-2a2c1cf3d6f7	1036506.10	INR	CARD	SUCCEEDED	\N	2026-11-24 10:28:26.706815+00	2026-11-24 10:28:26.706815+00	2026-11-24 10:28:26.706815+00
13	19	PAY-2026-D000019	SANDBOX	sbx_EAF84EB18B357B	7e08c435-119e-4a71-87b3-3fe4574c8b59	355451.40	INR	UPI	SUCCEEDED	\N	2026-11-22 21:28:26.706815+00	2026-11-22 21:28:26.706815+00	2026-11-22 21:28:26.706815+00
14	20	PAY-2026-D005020	SANDBOX	\N	55d0dd13-b09b-4bc1-b96e-a8e0de4fd6dc	97881.00	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-21 08:08:26.706815+00	2026-11-21 08:08:26.706815+00
15	20	PAY-2026-D000020	SANDBOX	sbx_A0980C2B9C00FC	e5108c97-59cf-4fb1-b5a6-18e2e16381fd	97881.00	INR	NET_BANKING	SUCCEEDED	\N	2026-11-21 08:28:26.706815+00	2026-11-21 08:28:26.706815+00	2026-11-21 08:28:26.706815+00
16	21	PAY-2026-D000021	SANDBOX	sbx_777C0C55CE7DE0	28770327-9442-4e58-ba6f-67baf8375773	251617.30	INR	UPI	SUCCEEDED	\N	2026-11-19 19:28:26.706815+00	2026-11-19 19:28:26.706815+00	2026-11-19 19:28:26.706815+00
17	22	PAY-2026-D000022	SANDBOX	sbx_ADBF62174499CC	1c57b952-c218-4140-9f25-8b22f40a41e7	786540.80	INR	CARD	SUCCEEDED	\N	2026-11-18 06:28:26.706815+00	2026-11-18 06:28:26.706815+00	2026-11-18 06:28:26.706815+00
18	23	PAY-2026-D000023	SANDBOX	sbx_61F0929DB30002	85932b2f-901a-4a28-93b2-d29065228c18	5137661.00	INR	WALLET	SUCCEEDED	\N	2026-11-16 17:28:26.706815+00	2026-11-16 17:28:26.706815+00	2026-11-16 17:28:26.706815+00
19	24	PAY-2026-D005024	SANDBOX	\N	3ff49566-69dc-4729-bfa6-52128aaeabfa	224690.88	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-15 04:08:26.706815+00	2026-11-15 04:08:26.706815+00
20	24	PAY-2026-D000024	SANDBOX	sbx_CA515ADBC80ABE	cb154402-c97f-4d55-8343-cc2c5c2b7f67	224690.88	INR	CARD	SUCCEEDED	\N	2026-11-15 04:28:26.706815+00	2026-11-15 04:28:26.706815+00	2026-11-15 04:28:26.706815+00
21	25	PAY-2026-D000025	SANDBOX	sbx_D7F86F318DCCE0	b2f29012-4532-467a-b5c1-06b4cced1210	1729980.30	INR	UPI	SUCCEEDED	\N	2026-11-13 15:28:26.706815+00	2026-11-13 15:28:26.706815+00	2026-11-13 15:28:26.706815+00
22	26	PAY-2026-D000026	SANDBOX	sbx_675D24CF4F6413	90bcfc9c-8650-4181-b4ee-3943ab5289f6	4174840.00	INR	NET_BANKING	SUCCEEDED	\N	2026-11-12 02:28:26.706815+00	2026-11-12 02:28:26.706815+00	2026-11-12 02:28:26.706815+00
23	27	PAY-2026-D000027	SANDBOX	sbx_E421FBE41F0AD8	0a0650f9-58a2-40c3-8f4f-c0a74f3f9440	225833.12	INR	UPI	SUCCEEDED	\N	2026-11-24 07:28:26.706815+00	2026-11-24 07:28:26.706815+00	2026-11-24 07:28:26.706815+00
24	28	PAY-2026-D005028	SANDBOX	\N	aeb59d38-17ab-4311-b0a9-1cf6b2165b5f	440145.90	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-22 18:08:26.706815+00	2026-11-22 18:08:26.706815+00
25	28	PAY-2026-D000028	SANDBOX	sbx_12156C4ADC8C9A	61592b05-a536-4d90-bc5b-0303419465bc	440145.90	INR	CARD	SUCCEEDED	\N	2026-11-22 18:28:26.706815+00	2026-11-22 18:28:26.706815+00	2026-11-22 18:28:26.706815+00
26	29	PAY-2026-D000029	SANDBOX	sbx_7B2DA86309643F	82883717-e585-4b8a-af17-117b3252348b	1776938.40	INR	WALLET	SUCCEEDED	\N	2026-11-21 05:28:26.706815+00	2026-11-21 05:28:26.706815+00	2026-11-21 05:28:26.706815+00
27	30	PAY-2026-D000030	SANDBOX	sbx_FFF32FC460BCC3	3a26cb06-81a0-4122-b705-c23dbee9e657	76175.49	INR	CARD	SUCCEEDED	\N	2026-11-19 16:28:26.706815+00	2026-11-19 16:28:26.706815+00	2026-11-19 16:28:26.706815+00
28	31	PAY-2026-D000031	SANDBOX	sbx_4E47DA1D7AEAB8	80b3f472-4188-451f-bc86-e9445ad0943f	130953.45	INR	UPI	SUCCEEDED	\N	2026-11-18 03:28:26.706815+00	2026-11-18 03:28:26.706815+00	2026-11-18 03:28:26.706815+00
29	32	PAY-2026-D005032	SANDBOX	\N	28dfc133-79be-418c-90f5-e9c1aa2b9e63	1522908.00	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-16 14:08:26.706815+00	2026-11-16 14:08:26.706815+00
30	32	PAY-2026-D000032	SANDBOX	sbx_07B9BA6B7234C7	67542d56-cb01-49db-8868-78d0474d9b82	1522908.00	INR	NET_BANKING	SUCCEEDED	\N	2026-11-16 14:28:26.706815+00	2026-11-16 14:28:26.706815+00	2026-11-16 14:28:26.706815+00
31	33	PAY-2026-D000033	SANDBOX	sbx_4AED022E73ECCC	b4593a85-fa42-4f79-a16f-12196d9caeb3	3382234.00	INR	UPI	SUCCEEDED	\N	2026-11-15 01:28:26.706815+00	2026-11-15 01:28:26.706815+00	2026-11-15 01:28:26.706815+00
32	34	PAY-2026-D000034	SANDBOX	sbx_845E2BD79F5121	c68d85a3-5591-48a9-9019-c7eb6d8bf810	197418.72	INR	CARD	SUCCEEDED	\N	2026-11-13 12:28:26.706815+00	2026-11-13 12:28:26.706815+00	2026-11-13 12:28:26.706815+00
33	35	PAY-2026-D000035	SANDBOX	sbx_F19AB378F05853	e0c83ade-337b-4764-88e9-a9723a93649f	519645.45	INR	WALLET	SUCCEEDED	\N	2026-11-11 23:28:26.706815+00	2026-11-11 23:28:26.706815+00	2026-11-11 23:28:26.706815+00
34	36	PAY-2026-D005036	SANDBOX	\N	293ece26-2f38-4d66-bc0e-d7612457476a	656316.00	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-24 04:08:26.706815+00	2026-11-24 04:08:26.706815+00
35	36	PAY-2026-D000036	SANDBOX	sbx_C3BC147FE08D46	ae9271df-0b27-42cd-994d-218004517d7b	656316.00	INR	CARD	SUCCEEDED	\N	2026-11-24 04:28:26.706815+00	2026-11-24 04:28:26.706815+00	2026-11-24 04:28:26.706815+00
36	37	PAY-2026-D000037	SANDBOX	sbx_AF8B71AD6C1F19	25a3e945-409a-4e73-8761-d7a2ceb47f2a	202283.86	INR	UPI	SUCCEEDED	\N	2026-11-22 15:28:26.706815+00	2026-11-22 15:28:26.706815+00	2026-11-22 15:28:26.706815+00
37	38	PAY-2026-D000038	SANDBOX	sbx_BCE13F970F4959	74ad403e-3059-4afb-9639-3aedbcfa2315	1112020.20	INR	NET_BANKING	SUCCEEDED	\N	2026-11-21 02:28:26.706815+00	2026-11-21 02:28:26.706815+00	2026-11-21 02:28:26.706815+00
38	39	PAY-2026-D000039	SANDBOX	sbx_53342A16252139	35c2cc5a-edb3-4143-bf91-4c07ab31fa24	2790257.50	INR	UPI	SUCCEEDED	\N	2026-11-19 13:28:26.706815+00	2026-11-19 13:28:26.706815+00	2026-11-19 13:28:26.706815+00
39	40	PAY-2026-D005040	SANDBOX	\N	3e602e53-8680-4849-bf47-2199d58f2066	29199.69	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-18 00:08:26.706815+00	2026-11-18 00:08:26.706815+00
40	40	PAY-2026-D000040	SANDBOX	sbx_C2343055229D66	112df113-2819-44ec-96ed-d35983307bcd	29199.69	INR	CARD	SUCCEEDED	\N	2026-11-18 00:28:26.706815+00	2026-11-18 00:28:26.706815+00	2026-11-18 00:28:26.706815+00
41	41	PAY-2026-D000041	SANDBOX	sbx_A268CDAFB6D46B	a76d24ce-d0b4-4c8e-b847-547d5a5337a9	498290.40	INR	WALLET	SUCCEEDED	\N	2026-11-16 11:28:26.706815+00	2026-11-16 11:28:26.706815+00	2026-11-16 11:28:26.706815+00
42	42	PAY-2026-D000042	SANDBOX	sbx_932102BA9CC3EF	0df88db6-86be-4b1f-8ee6-9b9cf17377ac	90659.40	INR	CARD	SUCCEEDED	\N	2026-11-14 22:28:26.706815+00	2026-11-14 22:28:26.706815+00	2026-11-14 22:28:26.706815+00
43	43	PAY-2026-D000043	SANDBOX	sbx_E359E83039988A	3e4c0e94-695f-4a1e-8fe9-2d2c44eb10fa	2948171.00	INR	UPI	SUCCEEDED	\N	2026-11-13 09:28:26.706815+00	2026-11-13 09:28:26.706815+00	2026-11-13 09:28:26.706815+00
44	44	PAY-2026-D005044	SANDBOX	\N	7e2511bc-ea07-4e4d-a4c2-4aad49f67f08	310649.16	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-11 20:08:26.706815+00	2026-11-11 20:08:26.706815+00
45	44	PAY-2026-D000044	SANDBOX	sbx_CEBDBA47D4AAE0	5f5c3336-4d2d-4e35-9232-03ad5654b7f7	310649.16	INR	NET_BANKING	SUCCEEDED	\N	2026-11-11 20:28:26.706815+00	2026-11-11 20:28:26.706815+00	2026-11-11 20:28:26.706815+00
46	45	PAY-2026-D000045	SANDBOX	sbx_D43E657CF0BB76	d3d48c66-98a5-48c8-acf5-d60ca6dd5ddc	1629341.05	INR	UPI	SUCCEEDED	\N	2026-11-24 01:28:26.706815+00	2026-11-24 01:28:26.706815+00	2026-11-24 01:28:26.706815+00
47	46	PAY-2026-D000046	SANDBOX	sbx_4A636955DB91B0	a1346577-0a0a-4681-8e09-3094b707d687	195856.40	INR	CARD	SUCCEEDED	\N	2026-11-22 12:28:26.706815+00	2026-11-22 12:28:26.706815+00	2026-11-22 12:28:26.706815+00
48	47	PAY-2026-D000047	SANDBOX	sbx_5372AF6B4C4B6B	11443167-52c8-4e34-8185-1df619b2ad88	41177.28	INR	WALLET	SUCCEEDED	\N	2026-11-20 23:28:26.706815+00	2026-11-20 23:28:26.706815+00	2026-11-20 23:28:26.706815+00
49	48	PAY-2026-D005048	SANDBOX	\N	12b8eeab-8c9b-4393-8ae2-6ed26873aee0	152874.90	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-19 10:08:26.706815+00	2026-11-19 10:08:26.706815+00
50	48	PAY-2026-D000048	SANDBOX	sbx_0AB39AD8AD9E9A	868b9a35-f409-4c6e-a34f-556aa9c07695	152874.90	INR	CARD	SUCCEEDED	\N	2026-11-19 10:28:26.706815+00	2026-11-19 10:28:26.706815+00	2026-11-19 10:28:26.706815+00
51	49	PAY-2026-D000049	SANDBOX	sbx_D273D356A327DA	ad259385-c787-4dd0-a8e7-45083898f34f	1161810.30	INR	UPI	SUCCEEDED	\N	2026-11-17 21:28:26.706815+00	2026-11-17 21:28:26.706815+00	2026-11-17 21:28:26.706815+00
52	50	PAY-2026-D000050	SANDBOX	sbx_D72818938EC5F1	4a143d44-002e-4754-839d-d6f8830363bd	26844.41	INR	NET_BANKING	SUCCEEDED	\N	2026-11-16 08:28:26.706815+00	2026-11-16 08:28:26.706815+00	2026-11-16 08:28:26.706815+00
53	51	PAY-2026-D000051	SANDBOX	sbx_21B6F18ACAAB99	9ff89883-cb56-4e9d-a591-00db7a922fff	123271.65	INR	UPI	SUCCEEDED	\N	2026-11-14 19:28:26.706815+00	2026-11-14 19:28:26.706815+00	2026-11-14 19:28:26.706815+00
54	52	PAY-2026-D005052	SANDBOX	\N	e0689220-b565-4c5c-a110-aa1690ca038e	2239781.60	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-13 06:08:26.706815+00	2026-11-13 06:08:26.706815+00
55	52	PAY-2026-D000052	SANDBOX	sbx_C02E41400D9FCF	02ed272f-b75a-46d2-837a-372b88930c95	2239781.60	INR	CARD	SUCCEEDED	\N	2026-11-13 06:28:26.706815+00	2026-11-13 06:28:26.706815+00	2026-11-13 06:28:26.706815+00
56	53	PAY-2026-D000053	SANDBOX	sbx_75AE2677F4EC85	c0b15824-19db-4d79-bcbb-332cdfee7f40	1494234.00	INR	WALLET	SUCCEEDED	\N	2026-11-11 17:28:26.706815+00	2026-11-11 17:28:26.706815+00	2026-11-11 17:28:26.706815+00
57	54	PAY-2026-D000054	SANDBOX	sbx_6D5255AADEB9D9	72e549b5-ea14-4666-9273-b8b1cea85269	173818.72	INR	CARD	SUCCEEDED	\N	2026-11-23 22:28:26.706815+00	2026-11-23 22:28:26.706815+00	2026-11-23 22:28:26.706815+00
58	55	PAY-2026-D000055	SANDBOX	sbx_7753C0ED926C51	d4422faf-5977-43f7-9854-f0a13dfbe403	1131950.40	INR	UPI	SUCCEEDED	\N	2026-11-22 09:28:26.706815+00	2026-11-22 09:28:26.706815+00	2026-11-22 09:28:26.706815+00
59	56	PAY-2026-D005056	SANDBOX	\N	30f6e98e-c3d0-49bb-b9c6-3c274ec43cd3	870037.60	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-20 20:08:26.706815+00	2026-11-20 20:08:26.706815+00
60	56	PAY-2026-D000056	SANDBOX	sbx_F855CD9F143CB0	a31757b7-c40d-4064-99e6-ae80f620cd2c	870037.60	INR	NET_BANKING	SUCCEEDED	\N	2026-11-20 20:28:26.706815+00	2026-11-20 20:28:26.706815+00	2026-11-20 20:28:26.706815+00
61	57	PAY-2026-D000057	SANDBOX	sbx_841EAE64A15AA2	5211abfe-d2a3-4d24-b7cf-9f8b5147125c	14385.38	INR	UPI	SUCCEEDED	\N	2026-11-19 07:28:26.706815+00	2026-11-19 07:28:26.706815+00	2026-11-19 07:28:26.706815+00
62	58	PAY-2026-D000058	SANDBOX	sbx_707E8F77969298	1043a09f-ba18-49a7-9a93-3f34506acb0b	611948.00	INR	CARD	SUCCEEDED	\N	2026-11-17 18:28:26.706815+00	2026-11-17 18:28:26.706815+00	2026-11-17 18:28:26.706815+00
63	60	PAY-2026-D005060	SANDBOX	\N	b7cf14ae-a3f8-4b5d-9c17-fd56f5bfceaf	90895.40	INR	CARD	FAILED	Card declined by the bank (sandbox test card).	\N	2026-11-14 16:08:26.706815+00	2026-11-14 16:08:26.706815+00
64	60	PAY-2026-D000060	SANDBOX	sbx_A969C10C69E916	e774c361-f45f-421d-a784-ece2c64f69c3	90895.40	INR	CARD	SUCCEEDED	\N	2026-11-14 16:28:26.706815+00	2026-11-14 16:28:26.706815+00	2026-11-14 16:28:26.706815+00
65	1	PAY-2026-SYZ8EFEX	SANDBOX	sbx_TL262E9TJ8FY27	39c7e2cb-60f5-4fa3-b45d-adcd5f8ce769	441370.15	INR	WALLET	SUCCEEDED	\N	2026-11-24 16:49:00.06461+00	2026-11-24 16:49:00.039593+00	2026-11-24 16:49:00.110114+00
66	61	PAY-2026-5VFE7BH8	SANDBOX	\N	21d52ab7-773f-474f-bed7-692a610588f3	112100.00	INR	CARD	FAILED	Card number is not valid.	\N	2026-11-25 00:25:35.738668+00	2026-11-25 00:25:35.773068+00
67	61	PAY-2026-TMC5RGQW	SANDBOX	sbx_E63WHUTCVAEMBC	9a01427b-f563-4e3d-adf1-e38e5eea8429	112100.00	INR	CARD	SUCCEEDED	\N	2026-11-25 00:25:47.607926+00	2026-11-25 00:25:47.595539+00	2026-11-25 00:25:47.657715+00
68	62	PAY-2026-8C729A35	SANDBOX	sbx_NBAPMSYDV53FPH	c877922e-305b-4ca7-bf75-67abe7cecadd	52380.00	INR	UPI	SUCCEEDED	\N	2026-11-25 00:46:00.596777+00	2026-11-25 00:46:00.568767+00	2026-11-25 00:46:00.622834+00
\.


--
-- Data for Name: product_passports; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_passports (id, batch_id, public_token, qr_file_key, visibility_status, published_at, revoked_at, created_at) FROM stdin;
\.


--
-- Data for Name: production_order_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.production_order_events (id, production_order_id, previous_status, new_status, updated_by, notes, created_at) FROM stdin;
1	61	\N	CONFIRMED	254	Quotation QTN-2026-ANJAXC2U accepted	2026-11-25 00:24:41.623215+00
2	62	\N	CONFIRMED	254	Quotation QTN-2026-9CYBXSRQ accepted	2026-11-25 00:44:36.55935+00
\.


--
-- Data for Name: production_orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.production_orders (id, order_number, accepted_quotation_id, rfq_id, buyer_organization_id, manufacturer_organization_id, quantity, total_amount, currency, expected_completion, status, created_at, updated_at) FROM stdin;
1	ORD-2026-D000001	1	1	130	13	250.000	441370.15	INR	2026-11-14	CONFIRMED	2026-11-02 02:16:26.706815+00	2026-11-24 15:28:26.706815+00
2	ORD-2026-D000002	3	2	137	24	1000.000	887289.20	INR	2026-11-19	CONFIRMED	2026-11-02 12:04:26.706815+00	2026-11-24 14:28:26.706815+00
3	ORD-2026-D000003	5	3	144	35	5000.000	11069875.00	INR	2026-11-24	CONFIRMED	2026-11-02 21:52:26.706815+00	2026-11-24 13:28:26.706815+00
4	ORD-2026-D000004	7	4	151	46	200.000	45092.52	INR	2026-11-30	CONFIRMED	2026-11-03 07:40:26.706815+00	2026-11-24 12:28:26.706815+00
5	ORD-2026-D000005	9	5	158	57	750.000	207744.90	INR	2026-12-05	CONFIRMED	2026-11-03 17:28:26.706815+00	2026-11-24 16:28:26.706815+00
6	ORD-2026-D000006	11	6	165	68	2000.000	1083641.20	INR	2026-12-11	CONFIRMED	2026-11-04 03:16:26.706815+00	2026-11-24 15:28:26.706815+00
7	ORD-2026-D000007	13	7	172	79	100.000	118250.16	INR	2026-12-16	CONFIRMED	2026-11-04 13:04:26.706815+00	2026-11-24 14:28:26.706815+00
8	ORD-2026-D000008	15	8	179	90	500.000	475492.80	INR	2026-11-11	CONFIRMED	2026-11-04 22:52:26.706815+00	2026-11-24 13:28:26.706815+00
9	ORD-2026-D000009	17	9	186	101	1500.000	2070274.60	INR	2026-11-17	SCHEDULED	2026-11-05 17:40:26.706815+00	2026-11-24 12:28:26.706815+00
10	ORD-2026-D000010	19	10	193	11	50.000	95447.25	INR	2026-11-23	SCHEDULED	2026-11-06 03:28:26.706815+00	2026-11-24 16:28:26.706815+00
11	ORD-2026-D000011	21	11	200	22	250.000	349949.65	INR	2026-11-28	SCHEDULED	2026-11-06 13:16:26.706815+00	2026-11-24 15:28:26.706815+00
12	ORD-2026-D000012	23	12	207	33	1000.000	2289341.60	INR	2026-12-03	SCHEDULED	2026-11-06 23:04:26.706815+00	2026-11-24 14:28:26.706815+00
13	ORD-2026-D000013	25	13	214	44	5000.000	9930939.00	INR	2026-12-09	SCHEDULED	2026-11-07 08:52:26.706815+00	2026-11-24 13:28:26.706815+00
14	ORD-2026-D000014	27	14	221	55	200.000	393968.96	INR	2026-12-14	SCHEDULED	2026-11-07 18:40:26.706815+00	2026-11-24 12:28:26.706815+00
15	ORD-2026-D000015	29	15	228	66	750.000	265272.85	INR	2026-12-20	SCHEDULED	2026-11-08 04:28:26.706815+00	2026-11-24 16:28:26.706815+00
16	ORD-2026-D000016	31	16	235	77	2000.000	998067.60	INR	2026-11-15	IN_PRODUCTION	2026-11-08 14:16:26.706815+00	2026-11-24 15:28:26.706815+00
17	ORD-2026-D000017	33	17	242	88	100.000	85703.40	INR	2026-11-21	IN_PRODUCTION	2026-11-09 00:04:26.706815+00	2026-11-24 14:28:26.706815+00
18	ORD-2026-D000018	35	18	129	99	500.000	1036506.10	INR	2026-11-26	IN_PRODUCTION	2026-11-09 18:52:26.706815+00	2026-11-24 13:28:26.706815+00
19	ORD-2026-D000019	37	19	136	9	1500.000	355451.40	INR	2026-12-02	IN_PRODUCTION	2026-11-10 04:40:26.706815+00	2026-11-24 12:28:26.706815+00
20	ORD-2026-D000020	39	20	143	20	50.000	97881.00	INR	2026-12-07	IN_PRODUCTION	2026-11-10 14:28:26.706815+00	2026-11-24 16:28:26.706815+00
21	ORD-2026-D000021	41	21	150	31	250.000	251617.30	INR	2026-12-13	IN_PRODUCTION	2026-11-11 00:16:26.706815+00	2026-11-24 15:28:26.706815+00
22	ORD-2026-D000022	43	22	157	42	1000.000	786540.80	INR	2026-12-18	IN_PRODUCTION	2026-11-11 10:04:26.706815+00	2026-11-24 14:28:26.706815+00
23	ORD-2026-D000023	45	23	164	53	5000.000	5137661.00	INR	2026-12-23	IN_PRODUCTION	2026-11-11 19:52:26.706815+00	2026-11-24 13:28:26.706815+00
24	ORD-2026-D000024	47	24	171	64	200.000	224690.88	INR	2026-11-19	IN_PRODUCTION	2026-11-12 05:40:26.706815+00	2026-11-24 12:28:26.706815+00
25	ORD-2026-D000025	49	25	178	75	750.000	1729980.30	INR	2026-11-24	QUALITY_CHECK	2026-11-12 15:28:26.706815+00	2026-11-24 16:28:26.706815+00
26	ORD-2026-D000026	51	26	185	86	2000.000	4174840.00	INR	2026-11-30	QUALITY_CHECK	2026-11-13 01:16:26.706815+00	2026-11-24 15:28:26.706815+00
27	ORD-2026-D000027	53	27	192	97	100.000	225833.12	INR	2026-12-05	QUALITY_CHECK	2026-11-13 20:04:26.706815+00	2026-11-24 14:28:26.706815+00
28	ORD-2026-D000028	55	28	199	7	500.000	440145.90	INR	2026-12-11	QUALITY_CHECK	2026-11-14 05:52:26.706815+00	2026-11-24 13:28:26.706815+00
29	ORD-2026-D000029	57	29	206	18	1500.000	1776938.40	INR	2026-12-16	QUALITY_CHECK	2026-11-14 15:40:26.706815+00	2026-11-24 12:28:26.706815+00
30	ORD-2026-D000030	59	30	213	29	50.000	76175.49	INR	2026-12-22	QUALITY_CHECK	2026-11-15 01:28:26.706815+00	2026-11-24 16:28:26.706815+00
31	ORD-2026-D000031	61	31	220	40	250.000	130953.45	INR	2026-12-27	QUALITY_CHECK	2026-11-15 11:16:26.706815+00	2026-11-24 15:28:26.706815+00
32	ORD-2026-D000032	63	32	227	51	1000.000	1522908.00	INR	2026-11-22	READY_TO_SHIP	2026-11-15 21:04:26.706815+00	2026-11-24 14:28:26.706815+00
33	ORD-2026-D000033	65	33	234	62	5000.000	3382234.00	INR	2026-11-28	READY_TO_SHIP	2026-11-16 06:52:26.706815+00	2026-11-24 13:28:26.706815+00
34	ORD-2026-D000034	67	34	241	73	200.000	197418.72	INR	2026-12-03	READY_TO_SHIP	2026-11-16 16:40:26.706815+00	2026-11-24 12:28:26.706815+00
35	ORD-2026-D000035	69	35	128	84	750.000	519645.45	INR	2026-12-09	READY_TO_SHIP	2026-11-17 02:28:26.706815+00	2026-11-24 16:28:26.706815+00
36	ORD-2026-D000036	71	36	135	95	2000.000	656316.00	INR	2026-12-14	READY_TO_SHIP	2026-11-17 21:16:26.706815+00	2026-11-24 15:28:26.706815+00
37	ORD-2026-D000037	73	37	142	5	100.000	202283.86	INR	2026-12-20	READY_TO_SHIP	2026-11-18 07:04:26.706815+00	2026-11-24 14:28:26.706815+00
38	ORD-2026-D000038	75	38	149	16	500.000	1112020.20	INR	2026-12-25	SHIPPED	2026-11-18 16:52:26.706815+00	2026-11-24 13:28:26.706815+00
39	ORD-2026-D000039	77	39	156	27	1500.000	2790257.50	INR	2026-12-31	SHIPPED	2026-11-19 02:40:26.706815+00	2026-11-24 12:28:26.706815+00
40	ORD-2026-D000040	79	40	163	38	50.000	29199.69	INR	2026-11-26	SHIPPED	2026-11-19 12:28:26.706815+00	2026-11-24 16:28:26.706815+00
41	ORD-2026-D000041	81	41	170	49	250.000	498290.40	INR	2026-12-01	SHIPPED	2026-11-19 22:16:26.706815+00	2026-11-24 15:28:26.706815+00
42	ORD-2026-D000042	83	42	177	60	1000.000	90659.40	INR	2026-12-07	SHIPPED	2026-11-20 08:04:26.706815+00	2026-11-24 14:28:26.706815+00
43	ORD-2026-D000043	85	43	184	71	5000.000	2948171.00	INR	2026-12-12	SHIPPED	2026-11-20 17:52:26.706815+00	2026-11-24 13:28:26.706815+00
44	ORD-2026-D000044	87	44	191	82	200.000	310649.16	INR	2026-12-18	DELIVERED	2026-11-21 03:40:26.706815+00	2026-11-24 12:28:26.706815+00
45	ORD-2026-D000045	89	45	198	93	750.000	1629341.05	INR	2026-12-23	DELIVERED	2026-11-21 22:28:26.706815+00	2026-11-24 16:28:26.706815+00
46	ORD-2026-D000046	91	46	205	3	2000.000	195856.40	INR	2026-12-29	DELIVERED	2026-11-22 08:16:26.706815+00	2026-11-24 15:28:26.706815+00
47	ORD-2026-D000047	93	47	212	14	100.000	41177.28	INR	2027-01-03	DELIVERED	2026-11-22 18:04:26.706815+00	2026-11-24 14:28:26.706815+00
48	ORD-2026-D000048	95	48	219	25	500.000	152874.90	INR	2026-11-30	DELIVERED	2026-11-23 03:52:26.706815+00	2026-11-24 13:28:26.706815+00
49	ORD-2026-D000049	97	49	226	36	1500.000	1161810.30	INR	2026-12-05	COMPLETED	2026-11-23 13:40:26.706815+00	2026-11-24 12:28:26.706815+00
50	ORD-2026-D000050	99	50	233	47	50.000	26844.41	INR	2026-12-10	COMPLETED	2026-11-23 23:28:26.706815+00	2026-11-24 16:28:26.706815+00
51	ORD-2026-D000051	101	51	240	58	250.000	123271.65	INR	2026-12-16	COMPLETED	2026-11-24 09:16:26.706815+00	2026-11-24 15:28:26.706815+00
52	ORD-2026-D000052	103	52	127	69	1000.000	2239781.60	INR	2026-12-21	COMPLETED	2026-11-24 19:04:26.706815+00	2026-11-24 14:28:26.706815+00
53	ORD-2026-D000053	105	53	134	80	5000.000	1494234.00	INR	2026-12-27	COMPLETED	2026-11-25 04:52:26.706815+00	2026-11-24 13:28:26.706815+00
54	ORD-2026-D000054	107	54	141	91	200.000	173818.72	INR	2027-01-01	COMPLETED	2026-11-25 23:40:26.706815+00	2026-11-24 12:28:26.706815+00
55	ORD-2026-D000055	109	55	148	102	750.000	1131950.40	INR	2027-01-07	COMPLETED	2026-11-26 09:28:26.706815+00	2026-11-24 16:28:26.706815+00
56	ORD-2026-D000056	111	56	155	12	2000.000	870037.60	INR	2026-12-03	COMPLETED	2026-11-26 19:16:26.706815+00	2026-11-24 15:28:26.706815+00
57	ORD-2026-D000057	113	57	162	23	100.000	14385.38	INR	2026-12-09	ON_HOLD	2026-11-27 05:04:26.706815+00	2026-11-24 14:28:26.706815+00
58	ORD-2026-D000058	115	58	169	34	500.000	611948.00	INR	2026-12-14	ON_HOLD	2026-11-27 14:52:26.706815+00	2026-11-24 13:28:26.706815+00
59	ORD-2026-D000059	117	59	176	45	1500.000	3218638.80	INR	2026-12-20	CANCELLED	2026-11-28 00:40:26.706815+00	2026-11-24 12:28:26.706815+00
60	ORD-2026-D000060	119	60	183	56	50.000	90895.40	INR	2026-12-25	CANCELLED	2026-11-28 10:28:26.706815+00	2026-11-24 16:28:26.706815+00
61	ORD-2026-QRKEE74S	184	86	243	244	500.000	112100.00	INR	2026-12-07	CONFIRMED	2026-11-25 00:24:41.557273+00	2026-11-25 00:24:41.557273+00
62	ORD-2026-SXECNPKH	185	87	243	244	500.000	52380.00	INR	2026-12-05	CONFIRMED	2026-11-25 00:44:36.523458+00	2026-11-25 00:44:36.523458+00
\.


--
-- Data for Name: quotations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quotations (id, quotation_number, rfq_id, manufacturer_organization_id, submitted_by, version_number, unit_price, setup_fee, tax_amount, total_amount, currency, lead_time_days, valid_until, terms, status, created_at, updated_at) FROM stdin;
1	QTN-2026-D000001	1	13	14	1	1496.17	0.00	67327.65	441370.15	INR	12	2026-11-16 02:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-29 02:16:26.706815+00	2026-11-02 02:16:26.706815+00
2	QTN-2026-D001001	1	14	15	1	1675.71	0.00	75406.95	494334.45	INR	17	2026-11-16 02:16:26.706815+00	100% against delivery.	REJECTED	2026-10-30 02:16:26.706815+00	2026-11-02 02:16:26.706815+00
3	QTN-2026-D000002	2	24	25	1	750.44	1500.00	135349.20	887289.20	INR	17	2026-11-16 12:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-29 12:04:26.706815+00	2026-11-02 12:04:26.706815+00
4	QTN-2026-D001002	2	25	26	1	840.49	1500.00	151558.20	993548.20	INR	22	2026-11-16 12:04:26.706815+00	100% against delivery.	REJECTED	2026-10-30 12:04:26.706815+00	2026-11-02 12:04:26.706815+00
5	QTN-2026-D000003	3	35	36	1	1875.75	2500.00	1688625.00	11069875.00	INR	22	2026-11-16 21:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-29 21:52:26.706815+00	2026-11-02 21:52:26.706815+00
6	QTN-2026-D001003	3	36	37	1	2100.84	2500.00	1891206.00	12397906.00	INR	27	2026-11-16 21:52:26.706815+00	100% against delivery.	REJECTED	2026-10-30 21:52:26.706815+00	2026-11-02 21:52:26.706815+00
7	QTN-2026-D000004	4	46	47	1	166.07	5000.00	6878.52	45092.52	INR	27	2026-11-17 07:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-30 07:40:26.706815+00	2026-11-03 07:40:26.706815+00
8	QTN-2026-D001004	4	47	48	1	186.00	5000.00	7596.00	49796.00	INR	32	2026-11-17 07:40:26.706815+00	100% against delivery.	REJECTED	2026-10-31 07:40:26.706815+00	2026-11-03 07:40:26.706815+00
9	QTN-2026-D000005	5	57	58	1	224.74	7500.00	31689.90	207744.90	INR	32	2026-11-17 17:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-30 17:28:26.706815+00	2026-11-03 17:28:26.706815+00
10	QTN-2026-D001005	5	58	59	1	251.71	7500.00	35330.85	231613.35	INR	37	2026-11-17 17:28:26.706815+00	100% against delivery.	REJECTED	2026-10-31 17:28:26.706815+00	2026-11-03 17:28:26.706815+00
11	QTN-2026-D000006	6	68	69	1	459.17	0.00	165301.20	1083641.20	INR	37	2026-11-18 03:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-31 03:16:26.706815+00	2026-11-04 03:16:26.706815+00
12	QTN-2026-D001006	6	69	70	1	514.27	0.00	185137.20	1213677.20	INR	42	2026-11-18 03:16:26.706815+00	100% against delivery.	REJECTED	2026-11-01 03:16:26.706815+00	2026-11-04 03:16:26.706815+00
13	QTN-2026-D000007	7	79	80	1	1002.12	0.00	18038.16	118250.16	INR	42	2026-11-18 13:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-31 13:04:26.706815+00	2026-11-04 13:04:26.706815+00
14	QTN-2026-D001007	7	80	81	1	1122.37	0.00	20202.66	132439.66	INR	47	2026-11-18 13:04:26.706815+00	100% against delivery.	REJECTED	2026-11-01 13:04:26.706815+00	2026-11-04 13:04:26.706815+00
15	QTN-2026-D000008	8	90	91	1	802.92	1500.00	72532.80	475492.80	INR	7	2026-11-18 22:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-10-31 22:52:26.706815+00	2026-11-04 22:52:26.706815+00
16	QTN-2026-D001008	8	91	92	1	899.27	1500.00	81204.30	532339.30	INR	12	2026-11-18 22:52:26.706815+00	100% against delivery.	REJECTED	2026-11-01 22:52:26.706815+00	2026-11-04 22:52:26.706815+00
17	QTN-2026-D000009	9	101	102	1	1167.98	2500.00	315804.60	2070274.60	INR	12	2026-11-19 17:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-01 17:40:26.706815+00	2026-11-05 17:40:26.706815+00
18	QTN-2026-D001009	9	102	103	1	1308.14	2500.00	353647.80	2318357.80	INR	17	2026-11-19 17:40:26.706815+00	100% against delivery.	REJECTED	2026-11-02 17:40:26.706815+00	2026-11-05 17:40:26.706815+00
19	QTN-2026-D000010	10	11	12	1	1517.75	5000.00	14559.75	95447.25	INR	17	2026-11-20 03:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-02 03:28:26.706815+00	2026-11-06 03:28:26.706815+00
20	QTN-2026-D001010	10	12	13	1	1699.88	5000.00	16198.92	106192.92	INR	22	2026-11-20 03:28:26.706815+00	100% against delivery.	REJECTED	2026-11-03 03:28:26.706815+00	2026-11-06 03:28:26.706815+00
21	QTN-2026-D000011	11	22	23	1	1156.27	7500.00	53382.15	349949.65	INR	22	2026-11-20 13:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-02 13:16:26.706815+00	2026-11-06 13:16:26.706815+00
22	QTN-2026-D001011	11	23	24	1	1295.02	7500.00	59625.90	390880.90	INR	27	2026-11-20 13:16:26.706815+00	100% against delivery.	REJECTED	2026-11-03 13:16:26.706815+00	2026-11-06 13:16:26.706815+00
23	QTN-2026-D000012	12	33	34	1	1940.12	0.00	349221.60	2289341.60	INR	27	2026-11-20 23:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-02 23:04:26.706815+00	2026-11-06 23:04:26.706815+00
24	QTN-2026-D001012	12	34	35	1	2172.93	0.00	391127.40	2564057.40	INR	32	2026-11-20 23:04:26.706815+00	100% against delivery.	REJECTED	2026-11-03 23:04:26.706815+00	2026-11-06 23:04:26.706815+00
25	QTN-2026-D000013	13	44	45	1	1683.21	0.00	1514889.00	9930939.00	INR	32	2026-11-21 08:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-03 08:52:26.706815+00	2026-11-07 08:52:26.706815+00
26	QTN-2026-D001013	13	45	46	1	1885.20	0.00	1696680.00	11122680.00	INR	37	2026-11-21 08:52:26.706815+00	100% against delivery.	REJECTED	2026-11-04 08:52:26.706815+00	2026-11-07 08:52:26.706815+00
27	QTN-2026-D000014	14	55	56	1	1661.86	1500.00	60096.96	393968.96	INR	37	2026-11-21 18:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-03 18:40:26.706815+00	2026-11-07 18:40:26.706815+00
28	QTN-2026-D001014	14	56	57	1	1861.28	1500.00	67276.08	441032.08	INR	42	2026-11-21 18:40:26.706815+00	100% against delivery.	REJECTED	2026-11-04 18:40:26.706815+00	2026-11-07 18:40:26.706815+00
29	QTN-2026-D000015	15	66	67	1	296.41	2500.00	40465.35	265272.85	INR	42	2026-11-22 04:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-04 04:28:26.706815+00	2026-11-08 04:28:26.706815+00
30	QTN-2026-D001015	15	67	68	1	331.98	2500.00	45267.30	296752.30	INR	47	2026-11-22 04:28:26.706815+00	100% against delivery.	REJECTED	2026-11-05 04:28:26.706815+00	2026-11-08 04:28:26.706815+00
31	QTN-2026-D000016	16	77	78	1	420.41	5000.00	152247.60	998067.60	INR	7	2026-11-22 14:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-04 14:16:26.706815+00	2026-11-08 14:16:26.706815+00
32	QTN-2026-D001016	16	78	79	1	470.86	5000.00	170409.60	1117129.60	INR	12	2026-11-22 14:16:26.706815+00	100% against delivery.	REJECTED	2026-11-05 14:16:26.706815+00	2026-11-08 14:16:26.706815+00
33	QTN-2026-D000017	17	88	89	1	651.30	7500.00	13073.40	85703.40	INR	12	2026-11-23 00:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-05 00:04:26.706815+00	2026-11-09 00:04:26.706815+00
34	QTN-2026-D001017	17	89	90	1	729.46	7500.00	14480.28	94926.28	INR	17	2026-11-23 00:04:26.706815+00	100% against delivery.	REJECTED	2026-11-06 00:04:26.706815+00	2026-11-09 00:04:26.706815+00
35	QTN-2026-D000018	18	99	100	1	1756.79	0.00	158111.10	1036506.10	INR	17	2026-11-23 18:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-05 18:52:26.706815+00	2026-11-09 18:52:26.706815+00
36	QTN-2026-D001018	18	100	101	1	1967.60	0.00	177084.00	1160884.00	INR	22	2026-11-23 18:52:26.706815+00	100% against delivery.	REJECTED	2026-11-06 18:52:26.706815+00	2026-11-09 18:52:26.706815+00
37	QTN-2026-D000019	19	9	10	1	200.82	0.00	54221.40	355451.40	INR	22	2026-11-24 04:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-06 04:40:26.706815+00	2026-11-10 04:40:26.706815+00
38	QTN-2026-D001019	19	10	11	1	224.92	0.00	60728.40	398108.40	INR	27	2026-11-24 04:40:26.706815+00	100% against delivery.	REJECTED	2026-11-07 04:40:26.706815+00	2026-11-10 04:40:26.706815+00
39	QTN-2026-D000020	20	20	21	1	1629.00	1500.00	14931.00	97881.00	INR	27	2026-11-24 14:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-06 14:28:26.706815+00	2026-11-10 14:28:26.706815+00
40	QTN-2026-D001020	20	21	22	1	1824.48	1500.00	16690.32	109414.32	INR	32	2026-11-24 14:28:26.706815+00	100% against delivery.	REJECTED	2026-11-07 14:28:26.706815+00	2026-11-10 14:28:26.706815+00
41	QTN-2026-D000021	21	31	32	1	842.94	2500.00	38382.30	251617.30	INR	32	2026-11-25 00:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-07 00:16:26.706815+00	2026-11-11 00:16:26.706815+00
42	QTN-2026-D001021	21	32	33	1	944.09	2500.00	42934.05	281456.55	INR	37	2026-11-25 00:16:26.706815+00	100% against delivery.	REJECTED	2026-11-08 00:16:26.706815+00	2026-11-11 00:16:26.706815+00
43	QTN-2026-D000022	22	42	43	1	661.56	5000.00	119980.80	786540.80	INR	37	2026-11-25 10:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-07 10:04:26.706815+00	2026-11-11 10:04:26.706815+00
44	QTN-2026-D001022	22	43	44	1	740.95	5000.00	134271.00	880221.00	INR	42	2026-11-25 10:04:26.706815+00	100% against delivery.	REJECTED	2026-11-08 10:04:26.706815+00	2026-11-11 10:04:26.706815+00
45	QTN-2026-D000023	23	53	54	1	869.29	7500.00	783711.00	5137661.00	INR	42	2026-11-25 19:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-07 19:52:26.706815+00	2026-11-11 19:52:26.706815+00
46	QTN-2026-D001023	23	54	55	1	973.60	7500.00	877590.00	5753090.00	INR	47	2026-11-25 19:52:26.706815+00	100% against delivery.	REJECTED	2026-11-08 19:52:26.706815+00	2026-11-11 19:52:26.706815+00
47	QTN-2026-D000024	24	64	65	1	952.08	0.00	34274.88	224690.88	INR	7	2026-11-26 05:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-08 05:40:26.706815+00	2026-11-12 05:40:26.706815+00
48	QTN-2026-D001024	24	65	66	1	1066.33	0.00	38387.88	251653.88	INR	12	2026-11-26 05:40:26.706815+00	100% against delivery.	REJECTED	2026-11-09 05:40:26.706815+00	2026-11-12 05:40:26.706815+00
49	QTN-2026-D000025	25	75	76	1	1954.78	0.00	263895.30	1729980.30	INR	12	2026-11-26 15:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-08 15:28:26.706815+00	2026-11-12 15:28:26.706815+00
50	QTN-2026-D001025	25	76	77	1	2189.35	0.00	295562.25	1937574.75	INR	17	2026-11-26 15:28:26.706815+00	100% against delivery.	REJECTED	2026-11-09 15:28:26.706815+00	2026-11-12 15:28:26.706815+00
51	QTN-2026-D000026	26	86	87	1	1768.25	1500.00	636840.00	4174840.00	INR	17	2026-11-27 01:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-09 01:16:26.706815+00	2026-11-13 01:16:26.706815+00
52	QTN-2026-D001026	26	87	88	1	1980.44	1500.00	713228.40	4675608.40	INR	22	2026-11-27 01:16:26.706815+00	100% against delivery.	REJECTED	2026-11-10 01:16:26.706815+00	2026-11-13 01:16:26.706815+00
53	QTN-2026-D000027	27	97	98	1	1888.84	2500.00	34449.12	225833.12	INR	22	2026-11-27 20:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-09 20:04:26.706815+00	2026-11-13 20:04:26.706815+00
54	QTN-2026-D001027	27	98	99	1	2115.50	2500.00	38529.00	252579.00	INR	27	2026-11-27 20:04:26.706815+00	100% against delivery.	REJECTED	2026-11-10 20:04:26.706815+00	2026-11-13 20:04:26.706815+00
55	QTN-2026-D000028	28	7	8	1	736.01	5000.00	67140.90	440145.90	INR	27	2026-11-28 05:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-10 05:52:26.706815+00	2026-11-14 05:52:26.706815+00
56	QTN-2026-D001028	28	8	9	1	824.33	5000.00	75089.70	492254.70	INR	32	2026-11-28 05:52:26.706815+00	100% against delivery.	REJECTED	2026-11-11 05:52:26.706815+00	2026-11-14 05:52:26.706815+00
57	QTN-2026-D000029	29	18	19	1	998.92	7500.00	271058.40	1776938.40	INR	32	2026-11-28 15:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-10 15:40:26.706815+00	2026-11-14 15:40:26.706815+00
58	QTN-2026-D001029	29	19	20	1	1118.79	7500.00	303423.30	1989108.30	INR	37	2026-11-28 15:40:26.706815+00	100% against delivery.	REJECTED	2026-11-11 15:40:26.706815+00	2026-11-14 15:40:26.706815+00
59	QTN-2026-D000030	30	29	30	1	1291.11	0.00	11619.99	76175.49	INR	37	2026-11-29 01:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-11 01:28:26.706815+00	2026-11-15 01:28:26.706815+00
60	QTN-2026-D001030	30	30	31	1	1446.04	0.00	13014.36	85316.36	INR	42	2026-11-29 01:28:26.706815+00	100% against delivery.	REJECTED	2026-11-12 01:28:26.706815+00	2026-11-15 01:28:26.706815+00
61	QTN-2026-D000031	31	40	41	1	443.91	0.00	19975.95	130953.45	INR	42	2026-11-29 11:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-11 11:16:26.706815+00	2026-11-15 11:16:26.706815+00
62	QTN-2026-D001031	31	41	42	1	497.18	0.00	22373.10	146668.10	INR	47	2026-11-29 11:16:26.706815+00	100% against delivery.	REJECTED	2026-11-12 11:16:26.706815+00	2026-11-15 11:16:26.706815+00
63	QTN-2026-D000032	32	51	52	1	1289.10	1500.00	232308.00	1522908.00	INR	7	2026-11-29 21:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-11 21:04:26.706815+00	2026-11-15 21:04:26.706815+00
64	QTN-2026-D001032	32	52	53	1	1443.79	1500.00	260152.20	1705442.20	INR	12	2026-11-29 21:04:26.706815+00	100% against delivery.	REJECTED	2026-11-12 21:04:26.706815+00	2026-11-15 21:04:26.706815+00
65	QTN-2026-D000033	33	62	63	1	572.76	2500.00	515934.00	3382234.00	INR	12	2026-11-30 06:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-12 06:52:26.706815+00	2026-11-16 06:52:26.706815+00
66	QTN-2026-D001033	33	63	64	1	641.49	2500.00	577791.00	3787741.00	INR	17	2026-11-30 06:52:26.706815+00	100% against delivery.	REJECTED	2026-11-13 06:52:26.706815+00	2026-11-16 06:52:26.706815+00
67	QTN-2026-D000034	34	73	74	1	811.52	5000.00	30114.72	197418.72	INR	17	2026-11-30 16:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-12 16:40:26.706815+00	2026-11-16 16:40:26.706815+00
68	QTN-2026-D001034	34	74	75	1	908.90	5000.00	33620.40	220400.40	INR	22	2026-11-30 16:40:26.706815+00	100% against delivery.	REJECTED	2026-11-13 16:40:26.706815+00	2026-11-16 16:40:26.706815+00
69	QTN-2026-D000035	35	84	85	1	577.17	7500.00	79267.95	519645.45	INR	22	2026-12-01 02:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-13 02:28:26.706815+00	2026-11-17 02:28:26.706815+00
70	QTN-2026-D001035	35	85	86	1	646.43	7500.00	88618.05	580940.55	INR	27	2026-12-01 02:28:26.706815+00	100% against delivery.	REJECTED	2026-11-14 02:28:26.706815+00	2026-11-17 02:28:26.706815+00
71	QTN-2026-D000036	36	95	96	1	278.10	0.00	100116.00	656316.00	INR	27	2026-12-01 21:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-13 21:16:26.706815+00	2026-11-17 21:16:26.706815+00
72	QTN-2026-D001036	36	96	97	1	311.47	0.00	112129.20	735069.20	INR	32	2026-12-01 21:16:26.706815+00	100% against delivery.	REJECTED	2026-11-14 21:16:26.706815+00	2026-11-17 21:16:26.706815+00
73	QTN-2026-D000037	37	5	6	1	1714.27	0.00	30856.86	202283.86	INR	32	2026-12-02 07:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-14 07:04:26.706815+00	2026-11-18 07:04:26.706815+00
74	QTN-2026-D001037	37	6	7	1	1919.98	0.00	34559.64	226557.64	INR	37	2026-12-02 07:04:26.706815+00	100% against delivery.	REJECTED	2026-11-15 07:04:26.706815+00	2026-11-18 07:04:26.706815+00
75	QTN-2026-D000038	38	16	17	1	1881.78	1500.00	169630.20	1112020.20	INR	37	2026-12-02 16:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-14 16:52:26.706815+00	2026-11-18 16:52:26.706815+00
76	QTN-2026-D001038	38	17	18	1	2107.59	1500.00	189953.10	1245248.10	INR	42	2026-12-02 16:52:26.706815+00	100% against delivery.	REJECTED	2026-11-15 16:52:26.706815+00	2026-11-18 16:52:26.706815+00
77	QTN-2026-D000039	39	27	28	1	1574.75	2500.00	425632.50	2790257.50	INR	42	2026-12-03 02:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-15 02:40:26.706815+00	2026-11-19 02:40:26.706815+00
78	QTN-2026-D001039	39	28	29	1	1763.72	2500.00	476654.40	3124734.40	INR	47	2026-12-03 02:40:26.706815+00	100% against delivery.	REJECTED	2026-11-16 02:40:26.706815+00	2026-11-19 02:40:26.706815+00
79	QTN-2026-D000040	40	38	39	1	394.91	5000.00	4454.19	29199.69	INR	7	2026-12-03 12:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-15 12:28:26.706815+00	2026-11-19 12:28:26.706815+00
80	QTN-2026-D001040	40	39	40	1	442.30	5000.00	4880.70	31995.70	INR	12	2026-12-03 12:28:26.706815+00	100% against delivery.	REJECTED	2026-11-16 12:28:26.706815+00	2026-11-19 12:28:26.706815+00
81	QTN-2026-D000041	41	49	50	1	1659.12	7500.00	76010.40	498290.40	INR	12	2026-12-03 22:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-15 22:16:26.706815+00	2026-11-19 22:16:26.706815+00
82	QTN-2026-D001041	41	50	51	1	1858.21	7500.00	84969.45	557021.95	INR	17	2026-12-03 22:16:26.706815+00	100% against delivery.	REJECTED	2026-11-16 22:16:26.706815+00	2026-11-19 22:16:26.706815+00
83	QTN-2026-D000042	42	60	61	1	76.83	0.00	13829.40	90659.40	INR	17	2026-12-04 08:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-16 08:04:26.706815+00	2026-11-20 08:04:26.706815+00
84	QTN-2026-D001042	42	61	62	1	86.05	0.00	15489.00	101539.00	INR	22	2026-12-04 08:04:26.706815+00	100% against delivery.	REJECTED	2026-11-17 08:04:26.706815+00	2026-11-20 08:04:26.706815+00
85	QTN-2026-D000043	43	71	72	1	499.69	0.00	449721.00	2948171.00	INR	22	2026-12-04 17:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-16 17:52:26.706815+00	2026-11-20 17:52:26.706815+00
86	QTN-2026-D001043	43	72	73	1	559.65	0.00	503685.00	3301935.00	INR	27	2026-12-04 17:52:26.706815+00	100% against delivery.	REJECTED	2026-11-17 17:52:26.706815+00	2026-11-20 17:52:26.706815+00
87	QTN-2026-D000044	44	82	83	1	1308.81	1500.00	47387.16	310649.16	INR	27	2026-12-05 03:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-17 03:40:26.706815+00	2026-11-21 03:40:26.706815+00
88	QTN-2026-D001044	44	83	84	1	1465.87	1500.00	53041.32	347715.32	INR	32	2026-12-05 03:40:26.706815+00	100% against delivery.	REJECTED	2026-11-18 03:40:26.706815+00	2026-11-21 03:40:26.706815+00
89	QTN-2026-D000045	45	93	94	1	1837.73	2500.00	248543.55	1629341.05	INR	32	2026-12-05 22:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-17 22:28:26.706815+00	2026-11-21 22:28:26.706815+00
90	QTN-2026-D001045	45	94	95	1	2058.26	2500.00	278315.10	1824510.10	INR	37	2026-12-05 22:28:26.706815+00	100% against delivery.	REJECTED	2026-11-18 22:28:26.706815+00	2026-11-21 22:28:26.706815+00
91	QTN-2026-D000046	46	3	4	1	80.49	5000.00	29876.40	195856.40	INR	37	2026-12-06 08:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-18 08:16:26.706815+00	2026-11-22 08:16:26.706815+00
92	QTN-2026-D001046	46	4	5	1	90.15	5000.00	33354.00	218654.00	INR	42	2026-12-06 08:16:26.706815+00	100% against delivery.	REJECTED	2026-11-19 08:16:26.706815+00	2026-11-22 08:16:26.706815+00
93	QTN-2026-D000047	47	14	15	1	273.96	7500.00	6281.28	41177.28	INR	42	2026-12-06 18:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-18 18:04:26.706815+00	2026-11-22 18:04:26.706815+00
94	QTN-2026-D001047	47	15	16	1	306.84	7500.00	6873.12	45057.12	INR	47	2026-12-06 18:04:26.706815+00	100% against delivery.	REJECTED	2026-11-19 18:04:26.706815+00	2026-11-22 18:04:26.706815+00
95	QTN-2026-D000048	48	25	26	1	259.11	0.00	23319.90	152874.90	INR	7	2026-12-07 03:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-19 03:52:26.706815+00	2026-11-23 03:52:26.706815+00
96	QTN-2026-D001048	48	26	27	1	290.20	0.00	26118.00	171218.00	INR	12	2026-12-07 03:52:26.706815+00	100% against delivery.	REJECTED	2026-11-20 03:52:26.706815+00	2026-11-23 03:52:26.706815+00
97	QTN-2026-D000049	49	36	37	1	656.39	0.00	177225.30	1161810.30	INR	12	2026-12-07 13:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-19 13:40:26.706815+00	2026-11-23 13:40:26.706815+00
98	QTN-2026-D001049	49	37	38	1	735.16	0.00	198493.20	1301233.20	INR	17	2026-12-07 13:40:26.706815+00	100% against delivery.	REJECTED	2026-11-20 13:40:26.706815+00	2026-11-23 13:40:26.706815+00
99	QTN-2026-D000050	50	47	48	1	424.99	1500.00	4094.91	26844.41	INR	17	2026-12-07 23:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-19 23:28:26.706815+00	2026-11-23 23:28:26.706815+00
100	QTN-2026-D001050	50	48	49	1	475.99	1500.00	4553.91	29853.41	INR	22	2026-12-07 23:28:26.706815+00	100% against delivery.	REJECTED	2026-11-20 23:28:26.706815+00	2026-11-23 23:28:26.706815+00
101	QTN-2026-D000051	51	58	59	1	407.87	2500.00	18804.15	123271.65	INR	22	2026-12-08 09:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-20 09:16:26.706815+00	2026-11-24 09:16:26.706815+00
102	QTN-2026-D001051	51	59	60	1	456.81	2500.00	21006.45	137708.95	INR	27	2026-12-08 09:16:26.706815+00	100% against delivery.	REJECTED	2026-11-21 09:16:26.706815+00	2026-11-24 09:16:26.706815+00
103	QTN-2026-D000052	52	69	70	1	1893.12	5000.00	341661.60	2239781.60	INR	27	2026-12-08 19:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-20 19:04:26.706815+00	2026-11-24 19:04:26.706815+00
104	QTN-2026-D001052	52	70	71	1	2120.29	5000.00	382552.20	2507842.20	INR	32	2026-12-08 19:04:26.706815+00	100% against delivery.	REJECTED	2026-11-21 19:04:26.706815+00	2026-11-24 19:04:26.706815+00
105	QTN-2026-D000053	53	80	81	1	251.76	7500.00	227934.00	1494234.00	INR	32	2026-12-09 04:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-21 04:52:26.706815+00	2026-11-25 04:52:26.706815+00
106	QTN-2026-D001053	53	81	82	1	281.97	7500.00	255123.00	1672473.00	INR	37	2026-12-09 04:52:26.706815+00	100% against delivery.	REJECTED	2026-11-22 04:52:26.706815+00	2026-11-25 04:52:26.706815+00
107	QTN-2026-D000054	54	91	92	1	736.52	0.00	26514.72	173818.72	INR	37	2026-12-09 23:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-21 23:40:26.706815+00	2026-11-25 23:40:26.706815+00
108	QTN-2026-D001054	54	92	93	1	824.90	0.00	29696.40	194676.40	INR	42	2026-12-09 23:40:26.706815+00	100% against delivery.	REJECTED	2026-11-22 23:40:26.706815+00	2026-11-25 23:40:26.706815+00
109	QTN-2026-D000055	55	102	103	1	1279.04	0.00	172670.40	1131950.40	INR	42	2026-12-10 09:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-22 09:28:26.706815+00	2026-11-26 09:28:26.706815+00
110	QTN-2026-D001055	55	2	3	1	1432.52	0.00	193390.20	1267780.20	INR	47	2026-12-10 09:28:26.706815+00	100% against delivery.	REJECTED	2026-11-23 09:28:26.706815+00	2026-11-26 09:28:26.706815+00
111	QTN-2026-D000056	56	12	13	1	367.91	1500.00	132717.60	870037.60	INR	7	2026-12-10 19:16:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-22 19:16:26.706815+00	2026-11-26 19:16:26.706815+00
112	QTN-2026-D001056	56	13	14	1	412.06	1500.00	148611.60	974231.60	INR	12	2026-12-10 19:16:26.706815+00	100% against delivery.	REJECTED	2026-11-23 19:16:26.706815+00	2026-11-26 19:16:26.706815+00
113	QTN-2026-D000057	57	23	24	1	96.91	2500.00	2194.38	14385.38	INR	12	2026-12-11 05:04:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-23 05:04:26.706815+00	2026-11-27 05:04:26.706815+00
114	QTN-2026-D001057	57	24	25	1	108.54	2500.00	2403.72	15757.72	INR	17	2026-12-11 05:04:26.706815+00	100% against delivery.	REJECTED	2026-11-24 05:04:26.706815+00	2026-11-27 05:04:26.706815+00
115	QTN-2026-D000058	58	34	35	1	1027.20	5000.00	93348.00	611948.00	INR	17	2026-12-11 14:52:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-23 14:52:26.706815+00	2026-11-27 14:52:26.706815+00
116	QTN-2026-D001058	58	35	36	1	1150.46	5000.00	104441.40	684671.40	INR	22	2026-12-11 14:52:26.706815+00	100% against delivery.	REJECTED	2026-11-24 14:52:26.706815+00	2026-11-27 14:52:26.706815+00
117	QTN-2026-D000059	59	45	46	1	1813.44	7500.00	490978.80	3218638.80	INR	22	2026-12-12 00:40:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-24 00:40:26.706815+00	2026-11-28 00:40:26.706815+00
118	QTN-2026-D001059	59	46	47	1	2031.05	7500.00	549733.50	3603808.50	INR	27	2026-12-12 00:40:26.706815+00	100% against delivery.	REJECTED	2026-11-25 00:40:26.706815+00	2026-11-28 00:40:26.706815+00
119	QTN-2026-D000060	60	56	57	1	1540.60	0.00	13865.40	90895.40	INR	27	2026-12-12 10:28:26.706815+00	50% advance, balance before dispatch. Ex-works.	ACCEPTED	2026-11-24 10:28:26.706815+00	2026-11-28 10:28:26.706815+00
120	QTN-2026-D001060	60	57	58	1	1725.47	0.00	15529.23	101802.73	INR	32	2026-12-12 10:28:26.706815+00	100% against delivery.	REJECTED	2026-11-25 10:28:26.706815+00	2026-11-28 10:28:26.706815+00
121	QTN-2026-D002610	61	84	85	1	483.68	0.00	21765.60	142685.60	INR	17	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-23 12:28:26.706815+00	2026-11-23 12:28:26.706815+00
122	QTN-2026-D002611	61	85	86	1	337.92	2000.00	15566.40	102046.40	INR	23	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-23 13:28:26.706815+00	2026-11-23 13:28:26.706815+00
123	QTN-2026-D002612	61	86	87	1	81.07	4500.00	4458.15	29225.65	INR	29	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-23 14:28:26.706815+00	2026-11-23 14:28:26.706815+00
124	QTN-2026-D002620	62	87	88	1	865.58	0.00	77902.20	510692.20	INR	18	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-22 11:28:26.706815+00	2026-11-22 11:28:26.706815+00
125	QTN-2026-D002621	62	88	89	1	80.55	2000.00	7609.50	49884.50	INR	24	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-22 12:28:26.706815+00	2026-11-22 12:28:26.706815+00
126	QTN-2026-D002630	63	90	91	1	385.72	0.00	69429.60	455149.60	INR	10	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-21 17:28:26.706815+00	2026-11-21 17:28:26.706815+00
127	QTN-2026-D002631	63	91	92	1	301.03	2000.00	54545.40	357575.40	INR	16	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-21 18:28:26.706815+00	2026-11-21 18:28:26.706815+00
128	QTN-2026-D002632	63	92	93	1	548.23	4500.00	99491.40	652221.40	INR	22	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-21 19:28:26.706815+00	2026-11-21 19:28:26.706815+00
129	QTN-2026-D002640	64	93	94	1	954.25	0.00	343530.00	2252030.00	INR	11	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-24 16:28:26.706815+00	2026-11-24 16:28:26.706815+00
130	QTN-2026-D002641	64	94	95	1	157.34	2000.00	57002.40	373682.40	INR	17	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-24 17:28:26.706815+00	2026-11-24 17:28:26.706815+00
131	QTN-2026-D002650	65	96	97	1	308.85	0.00	5559.30	36444.30	INR	12	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-23 15:28:26.706815+00	2026-11-23 15:28:26.706815+00
132	QTN-2026-D002651	65	97	98	1	414.32	2000.00	7817.76	51249.76	INR	18	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-23 16:28:26.706815+00	2026-11-23 16:28:26.706815+00
133	QTN-2026-D002652	65	98	99	1	935.04	4500.00	17640.72	115644.72	INR	24	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-23 17:28:26.706815+00	2026-11-23 17:28:26.706815+00
134	QTN-2026-D002660	66	99	100	1	802.26	0.00	36101.70	236666.70	INR	13	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-22 14:28:26.706815+00	2026-11-22 14:28:26.706815+00
135	QTN-2026-D002661	66	100	101	1	372.76	2000.00	17134.20	112324.20	INR	19	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-22 15:28:26.706815+00	2026-11-22 15:28:26.706815+00
136	QTN-2026-D002670	67	102	103	1	361.16	0.00	32504.40	213084.40	INR	14	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-21 13:28:26.706815+00	2026-11-21 13:28:26.706815+00
137	QTN-2026-D002671	67	2	3	1	350.01	2000.00	31860.90	208865.90	INR	20	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-21 14:28:26.706815+00	2026-11-21 14:28:26.706815+00
138	QTN-2026-D002672	67	3	4	1	198.34	4500.00	18660.60	122330.60	INR	26	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-21 15:28:26.706815+00	2026-11-21 15:28:26.706815+00
139	QTN-2026-D002680	68	4	5	1	350.36	0.00	63064.80	413424.80	INR	15	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-24 12:28:26.706815+00	2026-11-24 12:28:26.706815+00
140	QTN-2026-D002681	68	5	6	1	649.24	2000.00	117223.20	768463.20	INR	21	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-24 13:28:26.706815+00	2026-11-24 13:28:26.706815+00
141	QTN-2026-D002690	69	7	8	1	825.60	0.00	297216.00	1948416.00	INR	16	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-23 11:28:26.706815+00	2026-11-23 11:28:26.706815+00
142	QTN-2026-D002691	69	8	9	1	634.46	2000.00	228765.60	1499685.60	INR	22	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-23 12:28:26.706815+00	2026-11-23 12:28:26.706815+00
143	QTN-2026-D002692	69	9	10	1	567.29	4500.00	205034.40	1344114.40	INR	28	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-23 13:28:26.706815+00	2026-11-23 13:28:26.706815+00
144	QTN-2026-D002700	70	10	11	1	596.94	0.00	10744.92	70438.92	INR	17	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-22 17:28:26.706815+00	2026-11-22 17:28:26.706815+00
145	QTN-2026-D002701	70	11	12	1	296.50	2000.00	5697.00	37347.00	INR	23	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-22 18:28:26.706815+00	2026-11-22 18:28:26.706815+00
146	QTN-2026-D002710	71	13	14	1	859.78	0.00	38690.10	253635.10	INR	18	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-21 16:28:26.706815+00	2026-11-21 16:28:26.706815+00
147	QTN-2026-D002711	71	14	15	1	555.12	2000.00	25340.40	166120.40	INR	24	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-21 17:28:26.706815+00	2026-11-21 17:28:26.706815+00
148	QTN-2026-D002712	71	15	16	1	641.53	4500.00	29678.85	194561.35	INR	30	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-21 18:28:26.706815+00	2026-11-21 18:28:26.706815+00
149	QTN-2026-D002720	72	16	17	1	236.78	0.00	21310.20	139700.20	INR	10	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-24 15:28:26.706815+00	2026-11-24 15:28:26.706815+00
150	QTN-2026-D002721	72	17	18	1	500.08	2000.00	45367.20	297407.20	INR	16	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-24 16:28:26.706815+00	2026-11-24 16:28:26.706815+00
151	QTN-2026-D002730	73	19	20	1	949.85	0.00	170973.00	1120823.00	INR	11	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-23 14:28:26.706815+00	2026-11-23 14:28:26.706815+00
152	QTN-2026-D002731	73	20	21	1	140.66	2000.00	25678.80	168338.80	INR	17	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-23 15:28:26.706815+00	2026-11-23 15:28:26.706815+00
153	QTN-2026-D002732	73	21	22	1	96.64	4500.00	18205.20	119345.20	INR	23	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-23 16:28:26.706815+00	2026-11-23 16:28:26.706815+00
154	QTN-2026-D002740	74	22	23	1	655.27	0.00	235897.20	1546437.20	INR	12	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-22 13:28:26.706815+00	2026-11-22 13:28:26.706815+00
155	QTN-2026-D002741	74	23	24	1	797.59	2000.00	287492.40	1884672.40	INR	18	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-22 14:28:26.706815+00	2026-11-22 14:28:26.706815+00
156	QTN-2026-D002750	75	25	26	1	736.07	0.00	13249.26	86856.26	INR	13	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-21 12:28:26.706815+00	2026-11-21 12:28:26.706815+00
157	QTN-2026-D002751	75	26	27	1	577.96	2000.00	10763.28	70559.28	INR	19	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-21 13:28:26.706815+00	2026-11-21 13:28:26.706815+00
158	QTN-2026-D002752	75	27	28	1	856.04	4500.00	16218.72	106322.72	INR	25	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-21 14:28:26.706815+00	2026-11-21 14:28:26.706815+00
159	QTN-2026-D002760	76	28	29	1	912.70	0.00	41071.50	269246.50	INR	14	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-24 11:28:26.706815+00	2026-11-24 11:28:26.706815+00
160	QTN-2026-D002761	76	29	30	1	193.25	2000.00	9056.25	59368.75	INR	20	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-24 12:28:26.706815+00	2026-11-24 12:28:26.706815+00
161	QTN-2026-D002770	77	31	32	1	242.60	0.00	21834.00	143134.00	INR	15	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-23 17:28:26.706815+00	2026-11-23 17:28:26.706815+00
162	QTN-2026-D002771	77	32	33	1	190.36	2000.00	17492.40	114672.40	INR	21	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-23 18:28:26.706815+00	2026-11-23 18:28:26.706815+00
163	QTN-2026-D002772	77	33	34	1	330.46	4500.00	30551.40	200281.40	INR	27	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-23 19:28:26.706815+00	2026-11-23 19:28:26.706815+00
164	QTN-2026-D002780	78	34	35	1	297.81	0.00	53605.80	351415.80	INR	16	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-22 16:28:26.706815+00	2026-11-22 16:28:26.706815+00
165	QTN-2026-D002781	78	35	36	1	184.90	2000.00	33642.00	220542.00	INR	22	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-22 17:28:26.706815+00	2026-11-22 17:28:26.706815+00
166	QTN-2026-D002790	79	37	38	1	616.92	0.00	222091.20	1455931.20	INR	17	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-21 15:28:26.706815+00	2026-11-21 15:28:26.706815+00
167	QTN-2026-D002791	79	38	39	1	586.85	2000.00	211626.00	1387326.00	INR	23	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-21 16:28:26.706815+00	2026-11-21 16:28:26.706815+00
168	QTN-2026-D002792	79	39	40	1	387.72	4500.00	140389.20	920329.20	INR	29	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-21 17:28:26.706815+00	2026-11-21 17:28:26.706815+00
169	QTN-2026-D002800	80	40	41	1	872.78	0.00	15710.04	102988.04	INR	18	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-24 14:28:26.706815+00	2026-11-24 14:28:26.706815+00
170	QTN-2026-D002801	80	41	42	1	754.40	2000.00	13939.20	91379.20	INR	24	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-24 15:28:26.706815+00	2026-11-24 15:28:26.706815+00
171	QTN-2026-D002810	81	43	44	1	938.80	0.00	42246.00	276946.00	INR	10	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-23 13:28:26.706815+00	2026-11-23 13:28:26.706815+00
172	QTN-2026-D002811	81	44	45	1	910.57	2000.00	41335.65	270978.15	INR	16	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-23 14:28:26.706815+00	2026-11-23 14:28:26.706815+00
173	QTN-2026-D002812	81	45	46	1	848.73	4500.00	39002.85	255685.35	INR	22	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-23 15:28:26.706815+00	2026-11-23 15:28:26.706815+00
174	QTN-2026-D002820	82	46	47	1	249.85	0.00	22486.50	147411.50	INR	11	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-22 12:28:26.706815+00	2026-11-22 12:28:26.706815+00
175	QTN-2026-D002821	82	47	48	1	423.16	2000.00	38444.40	252024.40	INR	17	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-22 13:28:26.706815+00	2026-11-22 13:28:26.706815+00
176	QTN-2026-D002830	83	49	50	1	955.84	0.00	172051.20	1127891.20	INR	12	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-21 11:28:26.706815+00	2026-11-21 11:28:26.706815+00
177	QTN-2026-D002831	83	50	51	1	836.94	2000.00	151009.20	989949.20	INR	18	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-21 12:28:26.706815+00	2026-11-21 12:28:26.706815+00
178	QTN-2026-D002832	83	51	52	1	564.48	4500.00	102416.40	671396.40	INR	24	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-21 13:28:26.706815+00	2026-11-21 13:28:26.706815+00
179	QTN-2026-D002840	84	52	53	1	921.33	0.00	331678.80	2174338.80	INR	13	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-24 17:28:26.706815+00	2026-11-24 17:28:26.706815+00
180	QTN-2026-D002841	84	53	54	1	581.30	2000.00	209628.00	1374228.00	INR	19	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-24 18:28:26.706815+00	2026-11-24 18:28:26.706815+00
181	QTN-2026-D002850	85	55	56	1	650.50	0.00	11709.00	76759.00	INR	14	2026-12-04 16:28:26.706815+00	30% advance, 70% before dispatch.	SUBMITTED	2026-11-23 16:28:26.706815+00	2026-11-23 16:28:26.706815+00
182	QTN-2026-D002851	85	56	57	1	140.20	2000.00	2883.60	18903.60	INR	20	2026-12-05 16:28:26.706815+00	100% against delivery.	SUBMITTED	2026-11-23 17:28:26.706815+00	2026-11-23 17:28:26.706815+00
183	QTN-2026-D002852	85	57	58	1	797.31	4500.00	15161.58	99392.58	INR	26	2026-12-06 16:28:26.706815+00	50% advance, 50% on delivery.	SUBMITTED	2026-11-23 18:28:26.706815+00	2026-11-23 18:28:26.706815+00
184	QTN-2026-ANJAXC2U	86	244	255	1	185.00	2500.00	17100.00	112100.00	INR	12	2026-12-07 18:29:59+00	50% advance, balance before dispatch. Ex-works Chakan.	ACCEPTED	2026-11-25 00:15:42.488673+00	2026-11-25 00:24:41.507875+00
185	QTN-2026-9CYBXSRQ	87	244	255	1	92.00	2500.00	3880.00	52380.00	INR	10	2026-12-15 18:29:59+00	50% advance not required. Price includes powder coating and packing.	ACCEPTED	2026-11-25 00:43:42.087591+00	2026-11-25 00:44:36.482462+00
\.


--
-- Data for Name: recall_recipients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recall_recipients (id, recall_id, organization_id, notified_at, acknowledgement_status, acknowledged_at) FROM stdin;
\.


--
-- Data for Name: recalls; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recalls (id, batch_id, initiated_by, reason, severity, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews (id, order_id, buyer_organization_id, manufacturer_organization_id, reviewer_user_id, rating, comment, verified_purchase, created_at) FROM stdin;
\.


--
-- Data for Name: rfq_attachments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rfq_attachments (id, rfq_id, file_id, uploaded_by, created_at) FROM stdin;
\.


--
-- Data for Name: rfqs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rfqs (id, rfq_number, buyer_organization_id, created_by, title, description, process_id, material_id, quantity, quantity_unit, specifications, tolerance_notes, delivery_date, delivery_address, quote_deadline, status, created_at, updated_at) FROM stdin;
1	RFQ-2026-D000001	130	131	Pump housing	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	3	250.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-11-28	Stores, Gate 2, Ludhiana	2026-11-01 02:16:26.706815+00	AWARDED	2026-10-27 02:16:26.706815+00	2026-11-02 02:16:26.706815+00
2	RFQ-2026-D000002	137	138	Gearbox cover	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	7	1000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-03	Stores, Gate 2, Pune	2026-11-01 12:04:26.706815+00	AWARDED	2026-10-27 12:04:26.706815+00	2026-11-02 12:04:26.706815+00
3	RFQ-2026-D000003	144	145	Motor shaft 25 mm	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	2	5000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-08	Stores, Gate 2, Coimbatore	2026-11-01 21:52:26.706815+00	AWARDED	2026-10-27 21:52:26.706815+00	2026-11-02 21:52:26.706815+00
4	RFQ-2026-D000004	151	152	Valve body 2 inch	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	4	200.000	sets	\N	General tolerance ISO 2768-m unless stated.	2026-12-14	Stores, Gate 2, Jaipur	2026-11-02 07:40:26.706815+00	AWARDED	2026-10-28 07:40:26.706815+00	2026-11-03 07:40:26.706815+00
5	RFQ-2026-D000005	158	159	Mounting bracket	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	6	750.000	kg	\N	General tolerance ISO 2768-m unless stated.	2026-12-19	Stores, Gate 2, Rajkot	2026-11-02 17:28:26.706815+00	AWARDED	2026-10-28 17:28:26.706815+00	2026-11-03 17:28:26.706815+00
6	RFQ-2026-D000006	165	166	Control panel enclosure	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	2	2000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-25	Stores, Gate 2, Ludhiana	2026-11-03 03:16:26.706815+00	AWARDED	2026-10-29 03:16:26.706815+00	2026-11-04 03:16:26.706815+00
7	RFQ-2026-D000007	172	173	Bearing housing	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	4	100.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-30	Stores, Gate 2, Pune	2026-11-03 13:04:26.706815+00	AWARDED	2026-10-29 13:04:26.706815+00	2026-11-04 13:04:26.706815+00
8	RFQ-2026-D000008	179	180	Drive pulley	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	6	500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-11-25	Stores, Gate 2, Coimbatore	2026-11-03 22:52:26.706815+00	AWARDED	2026-10-29 22:52:26.706815+00	2026-11-04 22:52:26.706815+00
9	RFQ-2026-D000009	186	187	Hydraulic manifold block	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	1	1500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-01	Stores, Gate 2, Jaipur	2026-11-04 17:40:26.706815+00	AWARDED	2026-10-30 17:40:26.706815+00	2026-11-05 17:40:26.706815+00
10	RFQ-2026-D000010	193	194	Connecting rod	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	3	50.000	sets	\N	General tolerance ISO 2768-m unless stated.	2026-12-07	Stores, Gate 2, Rajkot	2026-11-05 03:28:26.706815+00	AWARDED	2026-10-31 03:28:26.706815+00	2026-11-06 03:28:26.706815+00
11	RFQ-2026-D000011	200	201	Brake drum	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	5	250.000	kg	\N	General tolerance ISO 2768-m unless stated.	2026-12-12	Stores, Gate 2, Ludhiana	2026-11-05 13:16:26.706815+00	AWARDED	2026-10-31 13:16:26.706815+00	2026-11-06 13:16:26.706815+00
12	RFQ-2026-D000012	207	208	Impeller 150 mm	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	3	1000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-17	Stores, Gate 2, Pune	2026-11-05 23:04:26.706815+00	AWARDED	2026-10-31 23:04:26.706815+00	2026-11-06 23:04:26.706815+00
13	RFQ-2026-D000013	214	215	Battery tray	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	6	5	5000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-23	Stores, Gate 2, Coimbatore	2026-11-06 08:52:26.706815+00	AWARDED	2026-11-01 08:52:26.706815+00	2026-11-07 08:52:26.706815+00
14	RFQ-2026-D000014	221	222	Heat sink plate	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	7	200.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-28	Stores, Gate 2, Jaipur	2026-11-06 18:40:26.706815+00	AWARDED	2026-11-01 18:40:26.706815+00	2026-11-07 18:40:26.706815+00
15	RFQ-2026-D000015	228	229	Bush sleeve	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	2	750.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-03	Stores, Gate 2, Rajkot	2026-11-07 04:28:26.706815+00	AWARDED	2026-11-02 04:28:26.706815+00	2026-11-08 04:28:26.706815+00
16	RFQ-2026-D000016	235	236	Tractor axle hub	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	4	2000.000	sets	\N	General tolerance ISO 2768-m unless stated.	2026-11-29	Stores, Gate 2, Ludhiana	2026-11-07 14:16:26.706815+00	AWARDED	2026-11-02 14:16:26.706815+00	2026-11-08 14:16:26.706815+00
17	RFQ-2026-D000017	242	243	Solar panel clamp	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	6	100.000	kg	\N	General tolerance ISO 2768-m unless stated.	2026-12-05	Stores, Gate 2, Pune	2026-11-08 00:04:26.706815+00	AWARDED	2026-11-03 00:04:26.706815+00	2026-11-09 00:04:26.706815+00
18	RFQ-2026-D000018	129	130	Drone arm bracket	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	1	500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-10	Stores, Gate 2, Coimbatore	2026-11-08 18:52:26.706815+00	AWARDED	2026-11-03 18:52:26.706815+00	2026-11-09 18:52:26.706815+00
19	RFQ-2026-D000019	136	137	Cable gland body	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	3	1500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-16	Stores, Gate 2, Jaipur	2026-11-09 04:40:26.706815+00	AWARDED	2026-11-04 04:40:26.706815+00	2026-11-10 04:40:26.706815+00
20	RFQ-2026-D000020	143	144	Steel flange DN50	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	5	50.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-21	Stores, Gate 2, Rajkot	2026-11-09 14:28:26.706815+00	AWARDED	2026-11-04 14:28:26.706815+00	2026-11-10 14:28:26.706815+00
21	RFQ-2026-D000021	150	151	Pump housing	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	1	250.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-27	Stores, Gate 2, Ludhiana	2026-11-10 00:16:26.706815+00	AWARDED	2026-11-05 00:16:26.706815+00	2026-11-11 00:16:26.706815+00
22	RFQ-2026-D000022	157	158	Gearbox cover	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	5	1000.000	sets	\N	General tolerance ISO 2768-m unless stated.	2027-01-01	Stores, Gate 2, Pune	2026-11-10 10:04:26.706815+00	AWARDED	2026-11-05 10:04:26.706815+00	2026-11-11 10:04:26.706815+00
23	RFQ-2026-D000023	164	165	Motor shaft 25 mm	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	7	5000.000	kg	\N	General tolerance ISO 2768-m unless stated.	2027-01-06	Stores, Gate 2, Coimbatore	2026-11-10 19:52:26.706815+00	AWARDED	2026-11-05 19:52:26.706815+00	2026-11-11 19:52:26.706815+00
24	RFQ-2026-D000024	171	172	Valve body 2 inch	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	2	200.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-03	Stores, Gate 2, Jaipur	2026-11-11 05:40:26.706815+00	AWARDED	2026-11-06 05:40:26.706815+00	2026-11-12 05:40:26.706815+00
25	RFQ-2026-D000025	178	179	Mounting bracket	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	4	750.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-08	Stores, Gate 2, Rajkot	2026-11-11 15:28:26.706815+00	AWARDED	2026-11-06 15:28:26.706815+00	2026-11-12 15:28:26.706815+00
26	RFQ-2026-D000026	185	186	Control panel enclosure	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	6	2000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-14	Stores, Gate 2, Ludhiana	2026-11-12 01:16:26.706815+00	AWARDED	2026-11-07 01:16:26.706815+00	2026-11-13 01:16:26.706815+00
27	RFQ-2026-D000027	192	193	Bearing housing	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	1	100.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-19	Stores, Gate 2, Pune	2026-11-12 20:04:26.706815+00	AWARDED	2026-11-07 20:04:26.706815+00	2026-11-13 20:04:26.706815+00
28	RFQ-2026-D000028	199	200	Drive pulley	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	4	500.000	sets	\N	General tolerance ISO 2768-m unless stated.	2026-12-25	Stores, Gate 2, Coimbatore	2026-11-13 05:52:26.706815+00	AWARDED	2026-11-08 05:52:26.706815+00	2026-11-14 05:52:26.706815+00
29	RFQ-2026-D000029	206	207	Hydraulic manifold block	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	6	1500.000	kg	\N	General tolerance ISO 2768-m unless stated.	2026-12-30	Stores, Gate 2, Jaipur	2026-11-13 15:40:26.706815+00	AWARDED	2026-11-08 15:40:26.706815+00	2026-11-14 15:40:26.706815+00
30	RFQ-2026-D000030	213	214	Connecting rod	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	1	50.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-05	Stores, Gate 2, Rajkot	2026-11-14 01:28:26.706815+00	AWARDED	2026-11-09 01:28:26.706815+00	2026-11-15 01:28:26.706815+00
31	RFQ-2026-D000031	220	221	Brake drum	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	3	250.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-10	Stores, Gate 2, Ludhiana	2026-11-14 11:16:26.706815+00	AWARDED	2026-11-09 11:16:26.706815+00	2026-11-15 11:16:26.706815+00
32	RFQ-2026-D000032	227	228	Impeller 150 mm	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	7	1000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-06	Stores, Gate 2, Pune	2026-11-14 21:04:26.706815+00	AWARDED	2026-11-09 21:04:26.706815+00	2026-11-15 21:04:26.706815+00
33	RFQ-2026-D000033	234	235	Battery tray	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	2	5000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-12	Stores, Gate 2, Coimbatore	2026-11-15 06:52:26.706815+00	AWARDED	2026-11-10 06:52:26.706815+00	2026-11-16 06:52:26.706815+00
34	RFQ-2026-D000034	241	242	Heat sink plate	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	4	200.000	sets	\N	General tolerance ISO 2768-m unless stated.	2026-12-17	Stores, Gate 2, Jaipur	2026-11-15 16:40:26.706815+00	AWARDED	2026-11-10 16:40:26.706815+00	2026-11-16 16:40:26.706815+00
35	RFQ-2026-D000035	128	129	Bush sleeve	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	6	6	750.000	kg	\N	General tolerance ISO 2768-m unless stated.	2026-12-23	Stores, Gate 2, Rajkot	2026-11-16 02:28:26.706815+00	AWARDED	2026-11-11 02:28:26.706815+00	2026-11-17 02:28:26.706815+00
36	RFQ-2026-D000036	135	136	Tractor axle hub	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	2	2000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-28	Stores, Gate 2, Ludhiana	2026-11-16 21:16:26.706815+00	AWARDED	2026-11-11 21:16:26.706815+00	2026-11-17 21:16:26.706815+00
37	RFQ-2026-D000037	142	143	Solar panel clamp	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	4	100.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-03	Stores, Gate 2, Pune	2026-11-17 07:04:26.706815+00	AWARDED	2026-11-12 07:04:26.706815+00	2026-11-18 07:04:26.706815+00
38	RFQ-2026-D000038	149	150	Drone arm bracket	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	6	500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-08	Stores, Gate 2, Coimbatore	2026-11-17 16:52:26.706815+00	AWARDED	2026-11-12 16:52:26.706815+00	2026-11-18 16:52:26.706815+00
39	RFQ-2026-D000039	156	157	Cable gland body	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	1	1500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-14	Stores, Gate 2, Jaipur	2026-11-18 02:40:26.706815+00	AWARDED	2026-11-13 02:40:26.706815+00	2026-11-19 02:40:26.706815+00
40	RFQ-2026-D000040	163	164	Steel flange DN50	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	3	50.000	sets	\N	General tolerance ISO 2768-m unless stated.	2026-12-10	Stores, Gate 2, Rajkot	2026-11-18 12:28:26.706815+00	AWARDED	2026-11-13 12:28:26.706815+00	2026-11-19 12:28:26.706815+00
41	RFQ-2026-D000041	170	171	Pump housing	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	5	250.000	kg	\N	General tolerance ISO 2768-m unless stated.	2026-12-15	Stores, Gate 2, Ludhiana	2026-11-18 22:16:26.706815+00	AWARDED	2026-11-13 22:16:26.706815+00	2026-11-19 22:16:26.706815+00
42	RFQ-2026-D000042	177	178	Gearbox cover	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	3	1000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-21	Stores, Gate 2, Pune	2026-11-19 08:04:26.706815+00	AWARDED	2026-11-14 08:04:26.706815+00	2026-11-20 08:04:26.706815+00
43	RFQ-2026-D000043	184	185	Motor shaft 25 mm	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	5	5000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-26	Stores, Gate 2, Coimbatore	2026-11-19 17:52:26.706815+00	AWARDED	2026-11-14 17:52:26.706815+00	2026-11-20 17:52:26.706815+00
44	RFQ-2026-D000044	191	192	Valve body 2 inch	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	7	200.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-01	Stores, Gate 2, Jaipur	2026-11-20 03:40:26.706815+00	AWARDED	2026-11-15 03:40:26.706815+00	2026-11-21 03:40:26.706815+00
45	RFQ-2026-D000045	198	199	Mounting bracket	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	2	750.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-06	Stores, Gate 2, Rajkot	2026-11-20 22:28:26.706815+00	AWARDED	2026-11-15 22:28:26.706815+00	2026-11-21 22:28:26.706815+00
46	RFQ-2026-D000046	205	206	Control panel enclosure	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	4	2000.000	sets	\N	General tolerance ISO 2768-m unless stated.	2027-01-12	Stores, Gate 2, Ludhiana	2026-11-21 08:16:26.706815+00	AWARDED	2026-11-16 08:16:26.706815+00	2026-11-22 08:16:26.706815+00
47	RFQ-2026-D000047	212	213	Bearing housing	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	6	100.000	kg	\N	General tolerance ISO 2768-m unless stated.	2027-01-17	Stores, Gate 2, Pune	2026-11-21 18:04:26.706815+00	AWARDED	2026-11-16 18:04:26.706815+00	2026-11-22 18:04:26.706815+00
48	RFQ-2026-D000048	219	220	Drive pulley	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	1	500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-14	Stores, Gate 2, Coimbatore	2026-11-22 03:52:26.706815+00	AWARDED	2026-11-17 03:52:26.706815+00	2026-11-23 03:52:26.706815+00
49	RFQ-2026-D000049	226	227	Hydraulic manifold block	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	6	3	1500.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-19	Stores, Gate 2, Jaipur	2026-11-22 13:40:26.706815+00	AWARDED	2026-11-17 13:40:26.706815+00	2026-11-23 13:40:26.706815+00
50	RFQ-2026-D000050	233	234	Connecting rod	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	5	50.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-24	Stores, Gate 2, Rajkot	2026-11-22 23:28:26.706815+00	AWARDED	2026-11-17 23:28:26.706815+00	2026-11-23 23:28:26.706815+00
51	RFQ-2026-D000051	240	241	Brake drum	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	1	250.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-30	Stores, Gate 2, Ludhiana	2026-11-23 09:16:26.706815+00	AWARDED	2026-11-18 09:16:26.706815+00	2026-11-24 09:16:26.706815+00
52	RFQ-2026-D000052	127	128	Impeller 150 mm	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	5	1000.000	sets	\N	General tolerance ISO 2768-m unless stated.	2027-01-04	Stores, Gate 2, Pune	2026-11-23 19:04:26.706815+00	AWARDED	2026-11-18 19:04:26.706815+00	2026-11-24 19:04:26.706815+00
53	RFQ-2026-D000053	134	135	Battery tray	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	7	5000.000	kg	\N	General tolerance ISO 2768-m unless stated.	2027-01-10	Stores, Gate 2, Coimbatore	2026-11-24 04:52:26.706815+00	AWARDED	2026-11-19 04:52:26.706815+00	2026-11-25 04:52:26.706815+00
54	RFQ-2026-D000054	141	142	Heat sink plate	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	2	200.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-15	Stores, Gate 2, Jaipur	2026-11-24 23:40:26.706815+00	AWARDED	2026-11-19 23:40:26.706815+00	2026-11-25 23:40:26.706815+00
55	RFQ-2026-D000055	148	149	Bush sleeve	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	5	4	750.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-21	Stores, Gate 2, Rajkot	2026-11-25 09:28:26.706815+00	AWARDED	2026-11-20 09:28:26.706815+00	2026-11-26 09:28:26.706815+00
56	RFQ-2026-D000056	155	156	Tractor axle hub	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	6	2000.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-17	Stores, Gate 2, Ludhiana	2026-11-25 19:16:26.706815+00	AWARDED	2026-11-20 19:16:26.706815+00	2026-11-26 19:16:26.706815+00
57	RFQ-2026-D000057	162	163	Solar panel clamp	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	3	2	100.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2026-12-23	Stores, Gate 2, Pune	2026-11-26 05:04:26.706815+00	AWARDED	2026-11-21 05:04:26.706815+00	2026-11-27 05:04:26.706815+00
58	RFQ-2026-D000058	169	170	Drone arm bracket	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	1	4	500.000	sets	\N	General tolerance ISO 2768-m unless stated.	2026-12-28	Stores, Gate 2, Coimbatore	2026-11-26 14:52:26.706815+00	AWARDED	2026-11-21 14:52:26.706815+00	2026-11-27 14:52:26.706815+00
59	RFQ-2026-D000059	176	177	Cable gland body	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	4	6	1500.000	kg	\N	General tolerance ISO 2768-m unless stated.	2027-01-03	Stores, Gate 2, Jaipur	2026-11-27 00:40:26.706815+00	AWARDED	2026-11-22 00:40:26.706815+00	2026-11-28 00:40:26.706815+00
60	RFQ-2026-D000060	183	184	Steel flange DN50	Please quote as per attached specification. Packing: corrugated box, max 25 kg per box.	2	1	50.000	pcs	\N	General tolerance ISO 2768-m unless stated.	2027-01-08	Stores, Gate 2, Rajkot	2026-11-27 10:28:26.706815+00	AWARDED	2026-11-22 10:28:26.706815+00	2026-11-28 10:28:26.706815+00
61	RFQ-2026-D000061	188	189	Pump housing	Looking for a reliable supplier for a repeat monthly requirement.	3	2	250.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-28 16:28:26.706815+00	OPEN	2026-11-23 11:28:26.706815+00	2026-11-23 11:28:26.706815+00
62	RFQ-2026-D000062	193	194	Gearbox cover	Looking for a reliable supplier for a repeat monthly requirement.	1	3	500.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-29 16:28:26.706815+00	OPEN	2026-11-22 10:28:26.706815+00	2026-11-22 10:28:26.706815+00
63	RFQ-2026-D000063	198	199	Motor shaft 25 mm	Looking for a reliable supplier for a repeat monthly requirement.	1	1	1000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-30 16:28:26.706815+00	OPEN	2026-11-21 16:28:26.706815+00	2026-11-21 16:28:26.706815+00
64	RFQ-2026-D000064	203	204	Valve body 2 inch	Looking for a reliable supplier for a repeat monthly requirement.	1	2	2000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-01 16:28:26.706815+00	OPEN	2026-11-24 15:28:26.706815+00	2026-11-24 15:28:26.706815+00
65	RFQ-2026-D000065	208	209	Mounting bracket	Looking for a reliable supplier for a repeat monthly requirement.	2	3	100.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-02 16:28:26.706815+00	OPEN	2026-11-23 14:28:26.706815+00	2026-11-23 14:28:26.706815+00
66	RFQ-2026-D000066	213	214	Control panel enclosure	Looking for a reliable supplier for a repeat monthly requirement.	2	1	250.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-27 16:28:26.706815+00	OPEN	2026-11-22 13:28:26.706815+00	2026-11-22 13:28:26.706815+00
67	RFQ-2026-D000067	218	219	Bearing housing	Looking for a reliable supplier for a repeat monthly requirement.	2	2	500.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-28 16:28:26.706815+00	OPEN	2026-11-21 12:28:26.706815+00	2026-11-21 12:28:26.706815+00
68	RFQ-2026-D000068	223	224	Drive pulley	Looking for a reliable supplier for a repeat monthly requirement.	3	1	1000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-29 16:28:26.706815+00	OPEN	2026-11-24 11:28:26.706815+00	2026-11-24 11:28:26.706815+00
69	RFQ-2026-D000069	228	229	Hydraulic manifold block	Looking for a reliable supplier for a repeat monthly requirement.	1	1	2000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-30 16:28:26.706815+00	OPEN	2026-11-23 10:28:26.706815+00	2026-11-23 10:28:26.706815+00
70	RFQ-2026-D000070	233	234	Connecting rod	Looking for a reliable supplier for a repeat monthly requirement.	1	2	100.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-01 16:28:26.706815+00	OPEN	2026-11-22 16:28:26.706815+00	2026-11-22 16:28:26.706815+00
71	RFQ-2026-D000071	238	239	Brake drum	Looking for a reliable supplier for a repeat monthly requirement.	1	1	250.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-02 16:28:26.706815+00	OPEN	2026-11-21 15:28:26.706815+00	2026-11-21 15:28:26.706815+00
72	RFQ-2026-D000072	123	124	Impeller 150 mm	Looking for a reliable supplier for a repeat monthly requirement.	2	1	500.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-27 16:28:26.706815+00	OPEN	2026-11-24 14:28:26.706815+00	2026-11-24 14:28:26.706815+00
73	RFQ-2026-D000073	128	129	Battery tray	Looking for a reliable supplier for a repeat monthly requirement.	2	2	1000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-28 16:28:26.706815+00	OPEN	2026-11-23 13:28:26.706815+00	2026-11-23 13:28:26.706815+00
74	RFQ-2026-D000074	133	134	Heat sink plate	Looking for a reliable supplier for a repeat monthly requirement.	2	1	2000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-29 16:28:26.706815+00	OPEN	2026-11-22 12:28:26.706815+00	2026-11-22 12:28:26.706815+00
75	RFQ-2026-D000075	138	139	Bush sleeve	Looking for a reliable supplier for a repeat monthly requirement.	3	1	100.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-30 16:28:26.706815+00	OPEN	2026-11-21 11:28:26.706815+00	2026-11-21 11:28:26.706815+00
76	RFQ-2026-D000076	143	144	Tractor axle hub	Looking for a reliable supplier for a repeat monthly requirement.	3	2	250.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-01 16:28:26.706815+00	OPEN	2026-11-24 10:28:26.706815+00	2026-11-24 10:28:26.706815+00
77	RFQ-2026-D000077	148	149	Solar panel clamp	Looking for a reliable supplier for a repeat monthly requirement.	1	1	500.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-02 16:28:26.706815+00	OPEN	2026-11-23 16:28:26.706815+00	2026-11-23 16:28:26.706815+00
78	RFQ-2026-D000078	153	154	Drone arm bracket	Looking for a reliable supplier for a repeat monthly requirement.	1	1	1000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-27 16:28:26.706815+00	OPEN	2026-11-22 15:28:26.706815+00	2026-11-22 15:28:26.706815+00
79	RFQ-2026-D000079	158	159	Cable gland body	Looking for a reliable supplier for a repeat monthly requirement.	1	2	2000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-28 16:28:26.706815+00	OPEN	2026-11-21 14:28:26.706815+00	2026-11-21 14:28:26.706815+00
80	RFQ-2026-D000080	163	164	Steel flange DN50	Looking for a reliable supplier for a repeat monthly requirement.	2	1	100.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-29 16:28:26.706815+00	OPEN	2026-11-24 13:28:26.706815+00	2026-11-24 13:28:26.706815+00
81	RFQ-2026-D000081	168	169	Pump housing	Looking for a reliable supplier for a repeat monthly requirement.	2	1	250.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-30 16:28:26.706815+00	OPEN	2026-11-23 12:28:26.706815+00	2026-11-23 12:28:26.706815+00
82	RFQ-2026-D000082	173	174	Gearbox cover	Looking for a reliable supplier for a repeat monthly requirement.	2	2	500.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-01 16:28:26.706815+00	OPEN	2026-11-22 11:28:26.706815+00	2026-11-22 11:28:26.706815+00
83	RFQ-2026-D000083	178	179	Motor shaft 25 mm	Looking for a reliable supplier for a repeat monthly requirement.	3	1	1000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-12-02 16:28:26.706815+00	OPEN	2026-11-21 10:28:26.706815+00	2026-11-21 10:28:26.706815+00
84	RFQ-2026-D000084	183	184	Valve body 2 inch	Looking for a reliable supplier for a repeat monthly requirement.	3	1	2000.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-27 16:28:26.706815+00	OPEN	2026-11-24 16:28:26.706815+00	2026-11-24 16:28:26.706815+00
85	RFQ-2026-D000085	188	189	Mounting bracket	Looking for a reliable supplier for a repeat monthly requirement.	1	2	100.000	pcs	\N	Critical dimensions marked on drawing; others ISO 2768-m.	2027-01-08	Receiving dock, Rajkot	2026-11-28 16:28:26.706815+00	OPEN	2026-11-23 15:28:26.706815+00	2026-11-23 15:28:26.706815+00
86	RFQ-2026-CZ8V728E	243	254	Battery enclosure bracket	L-shaped mounting bracket for a 48 V battery pack. Powder-coated black.	2	1	500.000	pcs	[["3 mm", "120 × 80 mm"]]	±0.2 mm on hole positions, others ISO 2768-m	2026-12-25	Pune, Maharashtra	2026-12-02 11:30:00+00	AWARDED	2026-11-25 00:13:09.997545+00	2026-11-25 00:24:41.507875+00
87	RFQ-2026-TBQZCX6X	243	254	Steel mounting bracket - batch 2	L-shaped mounting bracket, 3 mm sheet, 2 holes of 8 mm, powder coated black.	2	1	500.000	pcs	[["3 mm", "120 × 80 mm"]]	±0.2 mm on hole positions	2026-12-25	Pune, Maharashtra	2026-12-02 11:30:00+00	AWARDED	2026-11-25 00:42:11.391648+00	2026-11-25 00:44:36.484083+00
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, role_name, description) FROM stdin;
1	BUYER	Creates RFQs, accepts quotations, tracks orders
2	MANUFACTURER	Manages machines, quotes on RFQs, runs production
3	QUALITY_INSPECTOR	Inspects batches and approves or rejects them
4	ADMIN	Verifies organizations and manages the platform
\.


--
-- Data for Name: shipment_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipment_batches (shipment_id, batch_id, quantity) FROM stdin;
\.


--
-- Data for Name: shipment_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipment_events (id, shipment_id, event_status, event_time, location, remarks, created_at) FROM stdin;
\.


--
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipments (id, production_order_id, carrier_name, tracking_number, dispatch_date, expected_delivery, delivered_at, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_roles (user_id, role_id, assigned_at, assigned_by) FROM stdin;
1	4	2026-11-24 11:36:22.244163+00	\N
2	3	2026-11-24 11:36:22.244163+00	\N
3	2	2026-11-24 13:09:37.731209+00	\N
4	2	2026-11-24 15:55:54.490593+00	\N
5	2	2026-11-24 15:55:54.490593+00	\N
6	2	2026-11-24 15:55:54.490593+00	\N
7	2	2026-11-24 15:55:54.490593+00	\N
8	2	2026-11-24 15:55:54.490593+00	\N
9	2	2026-11-24 15:55:54.490593+00	\N
10	2	2026-11-24 15:55:54.490593+00	\N
11	2	2026-11-24 15:55:54.490593+00	\N
12	2	2026-11-24 15:55:54.490593+00	\N
13	2	2026-11-24 15:55:54.490593+00	\N
14	2	2026-11-24 15:55:54.490593+00	\N
15	2	2026-11-24 15:55:54.490593+00	\N
16	2	2026-11-24 15:55:54.490593+00	\N
17	2	2026-11-24 15:55:54.490593+00	\N
18	2	2026-11-24 15:55:54.490593+00	\N
19	2	2026-11-24 15:55:54.490593+00	\N
20	2	2026-11-24 15:55:54.490593+00	\N
21	2	2026-11-24 15:55:54.490593+00	\N
22	2	2026-11-24 15:55:54.490593+00	\N
23	2	2026-11-24 15:55:54.490593+00	\N
24	2	2026-11-24 15:55:54.490593+00	\N
25	2	2026-11-24 15:55:54.490593+00	\N
26	2	2026-11-24 15:55:54.490593+00	\N
27	2	2026-11-24 15:55:54.490593+00	\N
28	2	2026-11-24 15:55:54.490593+00	\N
29	2	2026-11-24 15:55:54.490593+00	\N
30	2	2026-11-24 15:55:54.490593+00	\N
31	2	2026-11-24 15:55:54.490593+00	\N
32	2	2026-11-24 15:55:54.490593+00	\N
33	2	2026-11-24 15:55:54.490593+00	\N
34	2	2026-11-24 15:55:54.490593+00	\N
35	2	2026-11-24 15:55:54.490593+00	\N
36	2	2026-11-24 15:55:54.490593+00	\N
37	2	2026-11-24 15:55:54.490593+00	\N
38	2	2026-11-24 15:55:54.490593+00	\N
39	2	2026-11-24 15:55:54.490593+00	\N
40	2	2026-11-24 15:55:54.490593+00	\N
41	2	2026-11-24 15:55:54.490593+00	\N
42	2	2026-11-24 15:55:54.490593+00	\N
43	2	2026-11-24 15:55:54.490593+00	\N
44	2	2026-11-24 15:55:54.490593+00	\N
45	2	2026-11-24 15:55:54.490593+00	\N
46	2	2026-11-24 15:55:54.490593+00	\N
47	2	2026-11-24 15:55:54.490593+00	\N
48	2	2026-11-24 15:55:54.490593+00	\N
49	2	2026-11-24 15:55:54.490593+00	\N
50	2	2026-11-24 15:55:54.490593+00	\N
51	2	2026-11-24 15:55:54.490593+00	\N
52	2	2026-11-24 15:55:54.490593+00	\N
53	2	2026-11-24 15:55:54.490593+00	\N
54	2	2026-11-24 15:55:54.490593+00	\N
55	2	2026-11-24 15:55:54.490593+00	\N
56	2	2026-11-24 15:55:54.490593+00	\N
57	2	2026-11-24 15:55:54.490593+00	\N
58	2	2026-11-24 15:55:54.490593+00	\N
59	2	2026-11-24 15:55:54.490593+00	\N
60	2	2026-11-24 15:55:54.490593+00	\N
61	2	2026-11-24 15:55:54.490593+00	\N
62	2	2026-11-24 15:55:54.490593+00	\N
63	2	2026-11-24 15:55:54.490593+00	\N
64	2	2026-11-24 15:55:54.490593+00	\N
65	2	2026-11-24 15:55:54.490593+00	\N
66	2	2026-11-24 15:55:54.490593+00	\N
67	2	2026-11-24 15:55:54.490593+00	\N
68	2	2026-11-24 15:55:54.490593+00	\N
69	2	2026-11-24 15:55:54.490593+00	\N
70	2	2026-11-24 15:55:54.490593+00	\N
71	2	2026-11-24 15:55:54.490593+00	\N
72	2	2026-11-24 15:55:54.490593+00	\N
73	2	2026-11-24 15:55:54.490593+00	\N
74	2	2026-11-24 15:55:54.490593+00	\N
75	2	2026-11-24 15:55:54.490593+00	\N
76	2	2026-11-24 15:55:54.490593+00	\N
77	2	2026-11-24 15:55:54.490593+00	\N
78	2	2026-11-24 15:55:54.490593+00	\N
79	2	2026-11-24 15:55:54.490593+00	\N
80	2	2026-11-24 15:55:54.490593+00	\N
81	2	2026-11-24 15:55:54.490593+00	\N
82	2	2026-11-24 15:55:54.490593+00	\N
83	2	2026-11-24 15:55:54.490593+00	\N
84	2	2026-11-24 15:55:54.490593+00	\N
85	2	2026-11-24 15:55:54.490593+00	\N
86	2	2026-11-24 15:55:54.490593+00	\N
87	2	2026-11-24 15:55:54.490593+00	\N
88	2	2026-11-24 15:55:54.490593+00	\N
89	2	2026-11-24 15:55:54.490593+00	\N
90	2	2026-11-24 15:55:54.490593+00	\N
91	2	2026-11-24 15:55:54.490593+00	\N
92	2	2026-11-24 15:55:54.490593+00	\N
93	2	2026-11-24 15:55:54.490593+00	\N
94	2	2026-11-24 15:55:54.490593+00	\N
95	2	2026-11-24 15:55:54.490593+00	\N
96	2	2026-11-24 15:55:54.490593+00	\N
97	2	2026-11-24 15:55:54.490593+00	\N
98	2	2026-11-24 15:55:54.490593+00	\N
99	2	2026-11-24 15:55:54.490593+00	\N
100	2	2026-11-24 15:55:54.490593+00	\N
101	2	2026-11-24 15:55:54.490593+00	\N
102	2	2026-11-24 15:55:54.490593+00	\N
103	2	2026-11-24 15:55:54.490593+00	\N
104	2	2026-11-24 15:55:54.490593+00	\N
105	2	2026-11-24 15:55:54.490593+00	\N
106	2	2026-11-24 15:55:54.490593+00	\N
107	2	2026-11-24 15:55:54.490593+00	\N
108	2	2026-11-24 15:55:54.490593+00	\N
109	2	2026-11-24 15:55:54.490593+00	\N
110	2	2026-11-24 15:55:54.490593+00	\N
111	2	2026-11-24 15:55:54.490593+00	\N
112	2	2026-11-24 15:55:54.490593+00	\N
113	2	2026-11-24 15:55:54.490593+00	\N
114	2	2026-11-24 15:55:54.490593+00	\N
115	2	2026-11-24 15:55:54.490593+00	\N
116	2	2026-11-24 15:55:54.490593+00	\N
117	2	2026-11-24 15:55:54.490593+00	\N
118	2	2026-11-24 15:55:54.490593+00	\N
119	2	2026-11-24 15:55:54.490593+00	\N
120	2	2026-11-24 15:55:54.490593+00	\N
121	2	2026-11-24 15:55:54.490593+00	\N
122	2	2026-11-24 15:55:54.490593+00	\N
123	2	2026-11-24 15:55:54.490593+00	\N
124	1	2026-11-24 15:55:54.490593+00	\N
125	1	2026-11-24 15:55:54.490593+00	\N
126	1	2026-11-24 15:55:54.490593+00	\N
127	1	2026-11-24 15:55:54.490593+00	\N
128	1	2026-11-24 15:55:54.490593+00	\N
129	1	2026-11-24 15:55:54.490593+00	\N
130	1	2026-11-24 15:55:54.490593+00	\N
131	1	2026-11-24 15:55:54.490593+00	\N
132	1	2026-11-24 15:55:54.490593+00	\N
133	1	2026-11-24 15:55:54.490593+00	\N
134	1	2026-11-24 15:55:54.490593+00	\N
135	1	2026-11-24 15:55:54.490593+00	\N
136	1	2026-11-24 15:55:54.490593+00	\N
137	1	2026-11-24 15:55:54.490593+00	\N
138	1	2026-11-24 15:55:54.490593+00	\N
139	1	2026-11-24 15:55:54.490593+00	\N
140	1	2026-11-24 15:55:54.490593+00	\N
141	1	2026-11-24 15:55:54.490593+00	\N
142	1	2026-11-24 15:55:54.490593+00	\N
143	1	2026-11-24 15:55:54.490593+00	\N
144	1	2026-11-24 15:55:54.490593+00	\N
145	1	2026-11-24 15:55:54.490593+00	\N
146	1	2026-11-24 15:55:54.490593+00	\N
147	1	2026-11-24 15:55:54.490593+00	\N
148	1	2026-11-24 15:55:54.490593+00	\N
149	1	2026-11-24 15:55:54.490593+00	\N
150	1	2026-11-24 15:55:54.490593+00	\N
151	1	2026-11-24 15:55:54.490593+00	\N
152	1	2026-11-24 15:55:54.490593+00	\N
153	1	2026-11-24 15:55:54.490593+00	\N
154	1	2026-11-24 15:55:54.490593+00	\N
155	1	2026-11-24 15:55:54.490593+00	\N
156	1	2026-11-24 15:55:54.490593+00	\N
157	1	2026-11-24 15:55:54.490593+00	\N
158	1	2026-11-24 15:55:54.490593+00	\N
159	1	2026-11-24 15:55:54.490593+00	\N
160	1	2026-11-24 15:55:54.490593+00	\N
161	1	2026-11-24 15:55:54.490593+00	\N
162	1	2026-11-24 15:55:54.490593+00	\N
163	1	2026-11-24 15:55:54.490593+00	\N
164	1	2026-11-24 15:55:54.490593+00	\N
165	1	2026-11-24 15:55:54.490593+00	\N
166	1	2026-11-24 15:55:54.490593+00	\N
167	1	2026-11-24 15:55:54.490593+00	\N
168	1	2026-11-24 15:55:54.490593+00	\N
169	1	2026-11-24 15:55:54.490593+00	\N
170	1	2026-11-24 15:55:54.490593+00	\N
171	1	2026-11-24 15:55:54.490593+00	\N
172	1	2026-11-24 15:55:54.490593+00	\N
173	1	2026-11-24 15:55:54.490593+00	\N
174	1	2026-11-24 15:55:54.490593+00	\N
175	1	2026-11-24 15:55:54.490593+00	\N
176	1	2026-11-24 15:55:54.490593+00	\N
177	1	2026-11-24 15:55:54.490593+00	\N
178	1	2026-11-24 15:55:54.490593+00	\N
179	1	2026-11-24 15:55:54.490593+00	\N
180	1	2026-11-24 15:55:54.490593+00	\N
181	1	2026-11-24 15:55:54.490593+00	\N
182	1	2026-11-24 15:55:54.490593+00	\N
183	1	2026-11-24 15:55:54.490593+00	\N
184	1	2026-11-24 15:55:54.490593+00	\N
185	1	2026-11-24 15:55:54.490593+00	\N
186	1	2026-11-24 15:55:54.490593+00	\N
187	1	2026-11-24 15:55:54.490593+00	\N
188	1	2026-11-24 15:55:54.490593+00	\N
189	1	2026-11-24 15:55:54.490593+00	\N
190	1	2026-11-24 15:55:54.490593+00	\N
191	1	2026-11-24 15:55:54.490593+00	\N
192	1	2026-11-24 15:55:54.490593+00	\N
193	1	2026-11-24 15:55:54.490593+00	\N
194	1	2026-11-24 15:55:54.490593+00	\N
195	1	2026-11-24 15:55:54.490593+00	\N
196	1	2026-11-24 15:55:54.490593+00	\N
197	1	2026-11-24 15:55:54.490593+00	\N
198	1	2026-11-24 15:55:54.490593+00	\N
199	1	2026-11-24 15:55:54.490593+00	\N
200	1	2026-11-24 15:55:54.490593+00	\N
201	1	2026-11-24 15:55:54.490593+00	\N
202	1	2026-11-24 15:55:54.490593+00	\N
203	1	2026-11-24 15:55:54.490593+00	\N
204	1	2026-11-24 15:55:54.490593+00	\N
205	1	2026-11-24 15:55:54.490593+00	\N
206	1	2026-11-24 15:55:54.490593+00	\N
207	1	2026-11-24 15:55:54.490593+00	\N
208	1	2026-11-24 15:55:54.490593+00	\N
209	1	2026-11-24 15:55:54.490593+00	\N
210	1	2026-11-24 15:55:54.490593+00	\N
211	1	2026-11-24 15:55:54.490593+00	\N
212	1	2026-11-24 15:55:54.490593+00	\N
213	1	2026-11-24 15:55:54.490593+00	\N
214	1	2026-11-24 15:55:54.490593+00	\N
215	1	2026-11-24 15:55:54.490593+00	\N
216	1	2026-11-24 15:55:54.490593+00	\N
217	1	2026-11-24 15:55:54.490593+00	\N
218	1	2026-11-24 15:55:54.490593+00	\N
219	1	2026-11-24 15:55:54.490593+00	\N
220	1	2026-11-24 15:55:54.490593+00	\N
221	1	2026-11-24 15:55:54.490593+00	\N
222	1	2026-11-24 15:55:54.490593+00	\N
223	1	2026-11-24 15:55:54.490593+00	\N
224	1	2026-11-24 15:55:54.490593+00	\N
225	1	2026-11-24 15:55:54.490593+00	\N
226	1	2026-11-24 15:55:54.490593+00	\N
227	1	2026-11-24 15:55:54.490593+00	\N
228	1	2026-11-24 15:55:54.490593+00	\N
229	1	2026-11-24 15:55:54.490593+00	\N
230	1	2026-11-24 15:55:54.490593+00	\N
231	1	2026-11-24 15:55:54.490593+00	\N
232	1	2026-11-24 15:55:54.490593+00	\N
233	1	2026-11-24 15:55:54.490593+00	\N
234	1	2026-11-24 15:55:54.490593+00	\N
235	1	2026-11-24 15:55:54.490593+00	\N
236	1	2026-11-24 15:55:54.490593+00	\N
237	1	2026-11-24 15:55:54.490593+00	\N
238	1	2026-11-24 15:55:54.490593+00	\N
239	1	2026-11-24 15:55:54.490593+00	\N
240	1	2026-11-24 15:55:54.490593+00	\N
241	1	2026-11-24 15:55:54.490593+00	\N
242	1	2026-11-24 15:55:54.490593+00	\N
243	1	2026-11-24 15:55:54.490593+00	\N
244	3	2026-11-24 15:55:54.490593+00	\N
245	3	2026-11-24 15:55:54.490593+00	\N
246	3	2026-11-24 15:55:54.490593+00	\N
247	3	2026-11-24 15:55:54.490593+00	\N
248	3	2026-11-24 15:55:54.490593+00	\N
249	3	2026-11-24 15:55:54.490593+00	\N
250	3	2026-11-24 15:55:54.490593+00	\N
251	3	2026-11-24 15:55:54.490593+00	\N
252	3	2026-11-24 15:55:54.490593+00	\N
253	3	2026-11-24 15:55:54.490593+00	\N
254	1	2026-11-24 16:52:44.462384+00	\N
255	2	2026-11-24 16:55:50.440209+00	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, full_name, email, password_hash, phone, account_status, email_verified, last_login_at, created_at, updated_at) FROM stdin;
38	Karan Chauhan	mfr035@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800277165	ACTIVE	t	\N	2026-08-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
3	Webmints	yakshpanchal.dev@gmail.com	$2a$12$Wq2sFZZUSXyKnN5LnMh.Dua2lefCqHwWHV9YWaHgyQE75qGVR/oWq	\N	ACTIVE	f	2026-11-24 13:09:44.733502+00	2026-11-24 13:09:38.290079+00	2026-11-24 13:09:44.734498+00
2	Quality Inspector	inspector@forgetrace.local	$2a$12$O7PVbwf4s0NO4P1GtKwFve32DDUAJ87LjCIOxnqU.q.D5VGBilOx6	\N	ACTIVE	t	2026-11-25 00:01:55.337442+00	2026-11-24 11:36:22.930611+00	2026-11-25 00:01:55.337442+00
4	Arjun Patil	mfr001@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800007919	ACTIVE	t	\N	2026-11-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
5	Rahul Gupta	mfr002@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800015838	ACTIVE	t	\N	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
6	Ramesh Bhat	mfr003@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800023757	ACTIVE	t	\N	2026-11-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
7	Sneha Iyer	mfr004@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800031676	ACTIVE	t	\N	2026-11-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
8	Kavya Qureshi	mfr005@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800039595	ACTIVE	t	\N	2026-11-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
9	Lakshmi Yadav	mfr006@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800047514	ACTIVE	t	\N	2026-11-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
10	Farhan Saxena	mfr007@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800055433	ACTIVE	t	\N	2026-11-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
11	Gurpreet Kulkarni	mfr008@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800063352	ACTIVE	t	\N	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
12	Joseph Chatterjee	mfr009@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800071271	ACTIVE	t	\N	2026-10-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
13	Vikram Naidu	mfr010@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800079190	ACTIVE	t	\N	2026-10-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
14	Prakash Verma	mfr011@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800087109	ACTIVE	t	\N	2026-10-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
15	Kiran Singh	mfr012@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800095028	ACTIVE	t	\N	2026-10-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
16	Manoj Kapoor	mfr013@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800102947	ACTIVE	t	\N	2026-10-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
17	Ritu Fernandes	mfr014@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800110866	ACTIVE	t	\N	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
18	Isha Nair	mfr015@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800118785	ACTIVE	t	\N	2026-10-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
19	Rekha Menon	mfr016@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800126704	ACTIVE	t	\N	2026-10-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
20	Vivaan Mishra	mfr017@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800134623	ACTIVE	t	\N	2026-10-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
21	Rohan Sinha	mfr018@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800142542	ACTIVE	t	\N	2026-10-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
22	Amit Deshmukh	mfr019@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800150461	ACTIVE	t	\N	2026-09-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
23	Priya Mehta	mfr020@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800158380	ACTIVE	t	\N	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
24	Pooja Gowda	mfr021@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800166299	ACTIVE	t	\N	2026-09-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
25	Divya Patel	mfr022@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800174218	ACTIVE	t	\N	2026-09-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
26	Deepa Gill	mfr023@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800182137	ACTIVE	t	\N	2026-09-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
27	Ayesha Malhotra	mfr024@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800190056	ACTIVE	t	\N	2026-09-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
28	Harpreet DSouza	mfr025@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800197975	ACTIVE	t	\N	2026-09-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
29	Mary Reddy	mfr026@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800205894	ACTIVE	t	\N	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
30	Sanjay Pillai	mfr027@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800213813	ACTIVE	t	\N	2026-09-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
31	Hitesh Pandey	mfr028@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800221732	ACTIVE	t	\N	2026-09-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
32	Arun Bose	mfr029@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800229651	ACTIVE	t	\N	2026-08-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
33	Swati Joshi	mfr030@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800237570	ACTIVE	t	\N	2026-08-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
34	Anjali Agarwal	mfr031@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800245489	ACTIVE	t	\N	2026-08-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
35	Tanvi Hegde	mfr032@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800253408	ACTIVE	t	\N	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
36	Geeta Shah	mfr033@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800261327	ACTIVE	t	\N	2026-08-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
37	Aditya Khan	mfr034@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800269246	ACTIVE	t	\N	2026-08-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
39	Suresh Thakur	mfr036@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800285084	ACTIVE	t	\N	2026-08-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
40	Ananya Rao	mfr037@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800293003	ACTIVE	t	\N	2026-08-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
41	Neha Banerjee	mfr038@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800300922	ACTIVE	t	\N	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
42	Meena Das	mfr039@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800308841	ACTIVE	t	\N	2026-07-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
43	Imran Sharma	mfr040@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800316760	ACTIVE	t	\N	2026-07-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
44	Zoya Patil	mfr041@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800324679	ACTIVE	t	\N	2026-07-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
45	Manpreet Gupta	mfr042@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800332598	ACTIVE	t	\N	2026-07-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
46	Thomas Bhat	mfr043@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800340517	ACTIVE	t	\N	2026-07-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
47	Nitin Iyer	mfr044@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800348436	ACTIVE	t	\N	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
48	Nirav Qureshi	mfr045@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800356355	ACTIVE	t	\N	2026-07-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
49	Sunil Yadav	mfr046@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800364274	ACTIVE	t	\N	2026-07-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
50	Sonal Saxena	mfr047@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800372193	ACTIVE	t	\N	2026-07-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
51	Shreya Kulkarni	mfr048@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800380112	ACTIVE	t	\N	2026-07-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
52	Nisha Chatterjee	mfr049@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800388031	ACTIVE	t	\N	2026-06-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
53	Aarav Naidu	mfr050@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800395950	ACTIVE	t	\N	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
54	Arjun Verma	mfr051@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800403869	ACTIVE	t	\N	2026-06-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
55	Rahul Singh	mfr052@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800411788	ACTIVE	t	\N	2026-06-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
56	Ramesh Kapoor	mfr053@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800419707	ACTIVE	t	\N	2026-06-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
57	Sneha Fernandes	mfr054@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800427626	ACTIVE	t	\N	2026-06-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
58	Kavya Nair	mfr055@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800435545	ACTIVE	t	\N	2026-06-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
59	Lakshmi Menon	mfr056@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800443464	ACTIVE	t	\N	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
60	Farhan Mishra	mfr057@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800451383	ACTIVE	t	\N	2026-06-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
61	Gurpreet Sinha	mfr058@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800459302	ACTIVE	t	\N	2026-06-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
62	Joseph Deshmukh	mfr059@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800467221	ACTIVE	t	\N	2026-05-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
63	Vikram Mehta	mfr060@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800475140	ACTIVE	t	\N	2026-05-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
64	Prakash Gowda	mfr061@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800483059	ACTIVE	t	\N	2026-05-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
65	Kiran Patel	mfr062@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800490978	ACTIVE	t	\N	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
66	Manoj Gill	mfr063@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800498897	ACTIVE	t	\N	2026-05-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
67	Ritu Malhotra	mfr064@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800506816	ACTIVE	t	\N	2026-05-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
68	Isha DSouza	mfr065@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800514735	ACTIVE	t	\N	2026-05-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
69	Rekha Reddy	mfr066@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800522654	ACTIVE	t	\N	2026-05-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
70	Vivaan Pillai	mfr067@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800530573	ACTIVE	t	\N	2026-05-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
71	Rohan Pandey	mfr068@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800538492	ACTIVE	t	\N	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
72	Amit Bose	mfr069@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800546411	ACTIVE	t	\N	2026-05-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
73	Priya Joshi	mfr070@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800554330	ACTIVE	t	\N	2026-04-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
74	Pooja Agarwal	mfr071@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800562249	ACTIVE	t	\N	2026-04-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
75	Divya Hegde	mfr072@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800570168	ACTIVE	t	\N	2026-04-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
76	Deepa Shah	mfr073@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800578087	ACTIVE	t	\N	2026-04-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
77	Ayesha Khan	mfr074@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800586006	ACTIVE	t	\N	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
78	Harpreet Chauhan	mfr075@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800593925	ACTIVE	t	\N	2026-04-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
79	Mary Thakur	mfr076@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800601844	ACTIVE	t	\N	2026-04-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
80	Sanjay Rao	mfr077@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800609763	ACTIVE	t	\N	2026-04-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
81	Hitesh Banerjee	mfr078@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800617682	ACTIVE	t	\N	2026-04-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
82	Arun Das	mfr079@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800625601	ACTIVE	t	\N	2026-04-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
83	Swati Sharma	mfr080@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800633520	ACTIVE	t	\N	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
84	Anjali Patil	mfr081@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800641439	ACTIVE	t	\N	2026-03-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
85	Tanvi Gupta	mfr082@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800649358	ACTIVE	t	\N	2026-03-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
86	Geeta Bhat	mfr083@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800657277	ACTIVE	t	\N	2026-03-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
87	Aditya Iyer	mfr084@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800665196	ACTIVE	t	\N	2026-03-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
88	Karan Qureshi	mfr085@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800673115	ACTIVE	t	\N	2026-03-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
89	Suresh Yadav	mfr086@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800681034	ACTIVE	t	\N	2026-03-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
90	Ananya Saxena	mfr087@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800688953	ACTIVE	t	\N	2026-03-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
91	Neha Kulkarni	mfr088@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800696872	ACTIVE	t	\N	2026-03-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
92	Meena Chatterjee	mfr089@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800704791	ACTIVE	t	\N	2026-03-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
93	Imran Naidu	mfr090@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800712710	ACTIVE	t	\N	2026-02-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
94	Zoya Verma	mfr091@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800720629	ACTIVE	t	\N	2026-02-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
95	Manpreet Singh	mfr092@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800728548	ACTIVE	t	\N	2026-02-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
96	Thomas Kapoor	mfr093@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800736467	ACTIVE	t	\N	2026-02-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
97	Nitin Fernandes	mfr094@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800744386	ACTIVE	t	\N	2026-02-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
98	Nirav Nair	mfr095@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800752305	ACTIVE	t	\N	2026-02-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
99	Sunil Menon	mfr096@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800760224	ACTIVE	t	\N	2026-02-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
100	Sonal Mishra	mfr097@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800768143	ACTIVE	t	\N	2026-02-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
101	Shreya Sinha	mfr098@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800776062	ACTIVE	t	\N	2026-02-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
102	Nisha Deshmukh	mfr099@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800783981	ACTIVE	t	\N	2026-01-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
103	Aarav Mehta	mfr100@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800791900	ACTIVE	t	\N	2026-01-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
104	Arjun Gowda	mfr101@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800799819	ACTIVE	t	\N	2026-01-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
105	Rahul Patel	mfr102@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800807738	ACTIVE	t	\N	2026-01-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
106	Ramesh Gill	mfr103@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800815657	ACTIVE	t	\N	2026-01-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
107	Sneha Malhotra	mfr104@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800823576	ACTIVE	t	\N	2026-01-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
108	Kavya DSouza	mfr105@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800831495	ACTIVE	t	\N	2026-01-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
109	Lakshmi Reddy	mfr106@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800839414	ACTIVE	t	\N	2026-01-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
110	Farhan Pillai	mfr107@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800847333	ACTIVE	t	\N	2026-01-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
111	Gurpreet Pandey	mfr108@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800855252	ACTIVE	t	\N	2026-01-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
112	Joseph Bose	mfr109@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800863171	ACTIVE	t	\N	2026-01-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
113	Vikram Joshi	mfr110@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800871090	ACTIVE	t	\N	2025-12-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
114	Prakash Agarwal	mfr111@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800879009	ACTIVE	t	\N	2025-12-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
115	Kiran Hegde	mfr112@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800886928	ACTIVE	t	\N	2025-12-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
116	Manoj Shah	mfr113@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800894847	ACTIVE	t	\N	2025-12-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
117	Ritu Khan	mfr114@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800902766	ACTIVE	t	\N	2025-12-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
118	Isha Chauhan	mfr115@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800910685	ACTIVE	t	\N	2025-12-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
119	Rekha Thakur	mfr116@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800918604	ACTIVE	t	\N	2025-12-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
120	Vivaan Rao	mfr117@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800926523	ACTIVE	t	\N	2025-12-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
121	Rohan Banerjee	mfr118@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800934442	ACTIVE	t	\N	2025-12-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
122	Amit Das	mfr119@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800942361	ACTIVE	t	\N	2025-12-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
123	Priya Sharma	mfr120@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 9800950280	ACTIVE	t	\N	2025-11-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
125	Neha Yadav	buyer002@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700012302	ACTIVE	t	\N	2026-11-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
126	Farhan Bose	buyer003@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700018453	ACTIVE	t	\N	2026-11-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
127	Mary Singh	buyer004@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700024604	ACTIVE	t	\N	2026-11-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
128	Nirav Chauhan	buyer005@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700030755	ACTIVE	t	\N	2026-11-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
129	Ritu Sinha	buyer006@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700036906	ACTIVE	t	\N	2026-11-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
130	Geeta Patil	buyer007@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700043057	ACTIVE	t	\N	2026-11-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
132	Pooja Saxena	buyer009@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700055359	ACTIVE	t	\N	2026-11-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
133	Imran Joshi	buyer010@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700061510	ACTIVE	t	\N	2026-11-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
134	Joseph Kapoor	buyer011@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700067661	ACTIVE	t	\N	2026-11-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
135	Hitesh Thakur	buyer012@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700073812	ACTIVE	t	\N	2026-10-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
136	Sonal Deshmukh	buyer013@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700079963	ACTIVE	t	\N	2026-10-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
137	Rekha Gupta	buyer014@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700086114	ACTIVE	t	\N	2026-10-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
138	Karan DSouza	buyer015@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700092265	ACTIVE	t	\N	2026-10-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
139	Sneha Kulkarni	buyer016@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700098416	ACTIVE	t	\N	2026-10-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
140	Deepa Agarwal	buyer017@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700104567	ACTIVE	t	\N	2026-10-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
141	Manpreet Fernandes	buyer018@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700110718	ACTIVE	t	\N	2026-10-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
142	Prakash Rao	buyer019@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700116869	ACTIVE	t	\N	2026-10-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
143	Swati Mehta	buyer020@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700123020	ACTIVE	t	\N	2026-10-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
144	Nisha Bhat	buyer021@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700129171	ACTIVE	t	\N	2026-10-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
145	Rohan Reddy	buyer022@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700135322	ACTIVE	t	\N	2026-10-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
146	Ananya Chatterjee	buyer023@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700141473	ACTIVE	t	\N	2026-10-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
147	Lakshmi Hegde	buyer024@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700147624	ACTIVE	t	\N	2026-10-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
148	Harpreet Nair	buyer025@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700153775	SUSPENDED	t	\N	2026-10-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
149	Nitin Banerjee	buyer026@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700159926	ACTIVE	t	\N	2026-10-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
150	Manoj Gowda	buyer027@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700166077	ACTIVE	t	\N	2026-10-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
151	Tanvi Iyer	buyer028@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700172228	ACTIVE	t	\N	2026-09-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
152	Arjun Pillai	buyer029@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700178379	ACTIVE	t	\N	2026-09-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
153	Priya Naidu	buyer030@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700184530	ACTIVE	t	\N	2026-09-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
154	Meena Shah	buyer031@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700190681	ACTIVE	t	\N	2026-09-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
155	Gurpreet Menon	buyer032@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700196832	ACTIVE	t	\N	2026-09-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
156	Sanjay Das	buyer033@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700202983	ACTIVE	t	\N	2026-09-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
157	Sunil Patel	buyer034@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700209134	ACTIVE	t	\N	2026-09-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
158	Isha Qureshi	buyer035@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700215285	ACTIVE	t	\N	2026-09-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
159	Aditya Pandey	buyer036@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700221436	ACTIVE	t	\N	2026-09-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
160	Ramesh Verma	buyer037@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700227587	ACTIVE	t	\N	2026-09-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
161	Divya Khan	buyer038@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700233738	ACTIVE	t	\N	2026-09-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
162	Zoya Mishra	buyer039@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700239889	ACTIVE	t	\N	2026-09-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
163	Vikram Sharma	buyer040@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700246040	ACTIVE	t	\N	2026-09-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
164	Arun Gill	buyer041@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700252191	ACTIVE	t	\N	2026-09-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
165	Shreya Yadav	buyer042@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700258342	ACTIVE	t	\N	2026-09-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
166	Vivaan Bose	buyer043@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700264493	ACTIVE	t	\N	2026-08-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
167	Suresh Singh	buyer044@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700270644	ACTIVE	t	\N	2026-08-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
168	Kavya Chauhan	buyer045@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700276795	ACTIVE	t	\N	2026-08-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
169	Ayesha Sinha	buyer046@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700282946	ACTIVE	t	\N	2026-08-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
170	Thomas Patil	buyer047@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700289097	ACTIVE	t	\N	2026-08-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
171	Kiran Malhotra	buyer048@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700295248	ACTIVE	t	\N	2026-08-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
172	Anjali Saxena	buyer049@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700301399	ACTIVE	t	\N	2026-08-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
173	Aarav Joshi	buyer050@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700307550	SUSPENDED	t	\N	2026-08-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
174	Amit Kapoor	buyer051@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700313701	ACTIVE	t	\N	2026-08-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
175	Neha Thakur	buyer052@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700319852	ACTIVE	t	\N	2026-08-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
176	Farhan Deshmukh	buyer053@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700326003	ACTIVE	t	\N	2026-08-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
177	Mary Gupta	buyer054@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700332154	ACTIVE	t	\N	2026-08-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
178	Nirav DSouza	buyer055@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700338305	ACTIVE	t	\N	2026-08-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
179	Ritu Kulkarni	buyer056@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700344456	ACTIVE	t	\N	2026-08-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
180	Geeta Agarwal	buyer057@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700350607	ACTIVE	t	\N	2026-08-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
181	Rahul Fernandes	buyer058@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700356758	ACTIVE	t	\N	2026-07-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
182	Pooja Rao	buyer059@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700362909	ACTIVE	t	\N	2026-07-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
183	Imran Mehta	buyer060@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700369060	ACTIVE	t	\N	2026-07-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
184	Joseph Bhat	buyer061@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700375211	ACTIVE	t	\N	2026-07-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
185	Hitesh Reddy	buyer062@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700381362	ACTIVE	t	\N	2026-07-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
186	Sonal Chatterjee	buyer063@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700387513	ACTIVE	t	\N	2026-07-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
187	Rekha Hegde	buyer064@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700393664	ACTIVE	t	\N	2026-07-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
188	Karan Nair	buyer065@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700399815	ACTIVE	t	\N	2026-07-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
189	Sneha Banerjee	buyer066@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700405966	ACTIVE	t	\N	2026-07-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
190	Deepa Gowda	buyer067@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700412117	ACTIVE	t	\N	2026-07-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
191	Manpreet Iyer	buyer068@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700418268	ACTIVE	t	\N	2026-07-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
192	Prakash Pillai	buyer069@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700424419	ACTIVE	t	\N	2026-07-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
193	Swati Naidu	buyer070@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700430570	ACTIVE	t	\N	2026-07-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
194	Nisha Shah	buyer071@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700436721	ACTIVE	t	\N	2026-07-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
195	Rohan Menon	buyer072@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700442872	ACTIVE	t	\N	2026-07-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
196	Ananya Das	buyer073@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700449023	ACTIVE	t	\N	2026-07-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
197	Lakshmi Patel	buyer074@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700455174	ACTIVE	t	\N	2026-06-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
198	Harpreet Qureshi	buyer075@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700461325	SUSPENDED	t	\N	2026-06-27 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
199	Nitin Pandey	buyer076@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700467476	ACTIVE	t	\N	2026-06-25 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
200	Manoj Verma	buyer077@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700473627	ACTIVE	t	\N	2026-06-23 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
201	Tanvi Khan	buyer078@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700479778	ACTIVE	t	\N	2026-06-21 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
202	Arjun Mishra	buyer079@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700485929	ACTIVE	t	\N	2026-06-19 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
203	Priya Sharma	buyer080@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700492080	ACTIVE	t	\N	2026-06-17 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
204	Meena Gill	buyer081@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700498231	ACTIVE	t	\N	2026-06-15 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
205	Gurpreet Yadav	buyer082@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700504382	ACTIVE	t	\N	2026-06-13 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
206	Sanjay Bose	buyer083@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700510533	ACTIVE	t	\N	2026-06-11 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
207	Sunil Singh	buyer084@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700516684	ACTIVE	t	\N	2026-06-09 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
208	Isha Chauhan	buyer085@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700522835	ACTIVE	t	\N	2026-06-07 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
209	Aditya Sinha	buyer086@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700528986	ACTIVE	t	\N	2026-06-05 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
210	Ramesh Patil	buyer087@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700535137	ACTIVE	t	\N	2026-06-03 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
211	Divya Malhotra	buyer088@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700541288	ACTIVE	t	\N	2026-06-01 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
212	Zoya Saxena	buyer089@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700547439	ACTIVE	t	\N	2026-05-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
213	Vikram Joshi	buyer090@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700553590	ACTIVE	t	\N	2026-05-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
214	Arun Kapoor	buyer091@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700559741	ACTIVE	t	\N	2026-05-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
215	Shreya Thakur	buyer092@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700565892	ACTIVE	t	\N	2026-05-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
216	Vivaan Deshmukh	buyer093@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700572043	ACTIVE	t	\N	2026-05-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
217	Suresh Gupta	buyer094@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700578194	ACTIVE	t	\N	2026-05-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
218	Kavya DSouza	buyer095@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700584345	ACTIVE	t	\N	2026-05-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
219	Ayesha Kulkarni	buyer096@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700590496	ACTIVE	t	\N	2026-05-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
220	Thomas Agarwal	buyer097@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700596647	ACTIVE	t	\N	2026-05-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
221	Kiran Fernandes	buyer098@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700602798	ACTIVE	t	\N	2026-05-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
222	Anjali Rao	buyer099@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700608949	ACTIVE	t	\N	2026-05-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
223	Aarav Mehta	buyer100@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700615100	SUSPENDED	t	\N	2026-05-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
224	Amit Bhat	buyer101@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700621251	ACTIVE	t	\N	2026-05-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
225	Neha Reddy	buyer102@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700627402	ACTIVE	t	\N	2026-05-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
226	Farhan Chatterjee	buyer103@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700633553	ACTIVE	t	\N	2026-05-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
227	Mary Hegde	buyer104@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700639704	ACTIVE	t	\N	2026-04-30 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
228	Nirav Nair	buyer105@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700645855	ACTIVE	t	\N	2026-04-28 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
229	Ritu Banerjee	buyer106@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700652006	ACTIVE	t	\N	2026-04-26 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
230	Geeta Gowda	buyer107@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700658157	ACTIVE	t	\N	2026-04-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
231	Rahul Iyer	buyer108@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700664308	ACTIVE	t	\N	2026-04-22 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
232	Pooja Pillai	buyer109@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700670459	ACTIVE	t	\N	2026-04-20 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
233	Imran Naidu	buyer110@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700676610	ACTIVE	t	\N	2026-04-18 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
234	Joseph Shah	buyer111@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700682761	ACTIVE	t	\N	2026-04-16 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
235	Hitesh Menon	buyer112@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700688912	ACTIVE	t	\N	2026-04-14 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
236	Sonal Das	buyer113@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700695063	ACTIVE	t	\N	2026-04-12 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
237	Rekha Patel	buyer114@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700701214	ACTIVE	t	\N	2026-04-10 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
238	Karan Qureshi	buyer115@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700707365	ACTIVE	t	\N	2026-04-08 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
239	Sneha Pandey	buyer116@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700713516	ACTIVE	t	\N	2026-04-06 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
240	Deepa Verma	buyer117@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700719667	ACTIVE	t	\N	2026-04-04 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
241	Manpreet Khan	buyer118@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700725818	ACTIVE	t	\N	2026-04-02 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
242	Prakash Mishra	buyer119@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700731969	ACTIVE	t	\N	2026-03-31 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
243	Swati Sharma	buyer120@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700738120	ACTIVE	t	\N	2026-03-29 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
244	Ramesh Pillai	qa01@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
245	Lakshmi Fernandes	qa02@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
246	Joseph Patil	qa03@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
247	Kiran Pandey	qa04@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
248	Isha Nair	qa05@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
249	Rohan Gupta	qa06@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
250	Pooja Bose	qa07@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
251	Ayesha Menon	qa08@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
252	Sanjay Bhat	qa09@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
253	Swati Joshi	qa10@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	\N	ACTIVE	t	\N	2026-11-24 15:55:54.490593+00	2026-11-24 15:55:54.490593+00
1	Platform Admin	admin@forgetrace.local	$2a$12$JjWIg3jdF7XyxsmZwuAQaeNdys68Yw4rrpTg6PkHTBMz6gFSoq2te	\N	ACTIVE	t	2026-11-25 00:01:16.24322+00	2026-11-24 11:36:22.62881+00	2026-11-25 00:01:16.253395+00
124	Amit Gill	buyer001@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700006151	ACTIVE	t	2026-11-24 16:36:03.299779+00	2026-11-22 15:55:54.490593+00	2026-11-24 16:36:03.305678+00
131	Rahul Malhotra	buyer008@demo.forgetrace.in	$2a$12$u9xPz9Cs1ACDRv6/a/ZqjOlkWVVJhg8ZC3Uxz2WlTYQbgbkePs.EG	+91 8700049208	ACTIVE	t	2026-11-24 16:48:00.847977+00	2026-11-08 15:55:54.490593+00	2026-11-24 16:48:00.851843+00
254	Priya Sharma	priya@greenvolt.test	$2a$12$SOpidbzM2X7/rsRPgx1zJeZvdW39NFwI9ZLDLEZ9YX1iO4ve/lt56	+91 98200 11223	ACTIVE	f	2026-11-25 00:10:16.436608+00	2026-11-24 16:52:44.836942+00	2026-11-25 00:10:16.436608+00
255	Rajesh Patil	rajesh@patilfab.test	$2a$12$fZ6WTtr4nfEspL7eu9KxEO0/jINP1b0Ti9QPr4XXG7kwqyMTUrYni	+91 98900 44556	ACTIVE	f	2026-11-25 00:14:14.68507+00	2026-11-24 16:55:50.878033+00	2026-11-25 00:14:14.68507+00
\.


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 63, true);


--
-- Name: batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.batches_id_seq', 1, false);


--
-- Name: contact_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contact_requests_id_seq', 120, true);


--
-- Name: disputes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.disputes_id_seq', 1, false);


--
-- Name: file_objects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.file_objects_id_seq', 1, false);


--
-- Name: inspection_measurements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inspection_measurements_id_seq', 1, false);


--
-- Name: inspections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inspections_id_seq', 1, false);


--
-- Name: machine_availability_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.machine_availability_rules_id_seq', 2459, true);


--
-- Name: machine_maintenance_blocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.machine_maintenance_blocks_id_seq', 167, true);


--
-- Name: machine_reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.machine_reservations_id_seq', 1, false);


--
-- Name: machines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.machines_id_seq', 441, true);


--
-- Name: manufacturing_processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.manufacturing_processes_id_seq', 8, true);


--
-- Name: materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.materials_id_seq', 9, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 74, true);


--
-- Name: organization_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organization_members_id_seq', 255, true);


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organizations_id_seq', 244, true);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_id_seq', 68, true);


--
-- Name: product_passports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_passports_id_seq', 1, false);


--
-- Name: production_order_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.production_order_events_id_seq', 2, true);


--
-- Name: production_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.production_orders_id_seq', 62, true);


--
-- Name: quotations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quotations_id_seq', 185, true);


--
-- Name: recall_recipients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recall_recipients_id_seq', 1, false);


--
-- Name: recalls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recalls_id_seq', 1, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: rfq_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rfq_attachments_id_seq', 1, false);


--
-- Name: rfqs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rfqs_id_seq', 87, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 4, true);


--
-- Name: shipment_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipment_events_id_seq', 1, false);


--
-- Name: shipments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipments_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 255, true);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: batches batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (id);


--
-- Name: contact_requests contact_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_requests
    ADD CONSTRAINT contact_requests_pkey PRIMARY KEY (id);


--
-- Name: disputes disputes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disputes
    ADD CONSTRAINT disputes_pkey PRIMARY KEY (id);


--
-- Name: machine_reservations ex_reservation_no_overlap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_reservations
    ADD CONSTRAINT ex_reservation_no_overlap EXCLUDE USING gist (machine_id WITH =, tstzrange(start_at, end_at, '[)'::text) WITH &&) WHERE (((status)::text = 'ACTIVE'::text));


--
-- Name: file_objects file_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_objects
    ADD CONSTRAINT file_objects_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: inspection_measurements inspection_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspection_measurements
    ADD CONSTRAINT inspection_measurements_pkey PRIMARY KEY (id);


--
-- Name: inspections inspections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_pkey PRIMARY KEY (id);


--
-- Name: machine_availability_rules machine_availability_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_availability_rules
    ADD CONSTRAINT machine_availability_rules_pkey PRIMARY KEY (id);


--
-- Name: machine_maintenance_blocks machine_maintenance_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_maintenance_blocks
    ADD CONSTRAINT machine_maintenance_blocks_pkey PRIMARY KEY (id);


--
-- Name: machine_materials machine_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_materials
    ADD CONSTRAINT machine_materials_pkey PRIMARY KEY (machine_id, material_id);


--
-- Name: machine_processes machine_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_processes
    ADD CONSTRAINT machine_processes_pkey PRIMARY KEY (machine_id, process_id);


--
-- Name: machine_reservations machine_reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_reservations
    ADD CONSTRAINT machine_reservations_pkey PRIMARY KEY (id);


--
-- Name: machines machines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_pkey PRIMARY KEY (id);


--
-- Name: manufacturer_materials manufacturer_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_materials
    ADD CONSTRAINT manufacturer_materials_pkey PRIMARY KEY (manufacturer_id, material_id);


--
-- Name: manufacturer_processes manufacturer_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_processes
    ADD CONSTRAINT manufacturer_processes_pkey PRIMARY KEY (manufacturer_id, process_id);


--
-- Name: manufacturer_profiles manufacturer_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_profiles
    ADD CONSTRAINT manufacturer_profiles_pkey PRIMARY KEY (organization_id);


--
-- Name: manufacturing_processes manufacturing_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturing_processes
    ADD CONSTRAINT manufacturing_processes_pkey PRIMARY KEY (id);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: organization_members organization_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: product_passports product_passports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_passports
    ADD CONSTRAINT product_passports_pkey PRIMARY KEY (id);


--
-- Name: production_order_events production_order_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_order_events
    ADD CONSTRAINT production_order_events_pkey PRIMARY KEY (id);


--
-- Name: production_orders production_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_pkey PRIMARY KEY (id);


--
-- Name: quotations quotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_pkey PRIMARY KEY (id);


--
-- Name: recall_recipients recall_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recall_recipients
    ADD CONSTRAINT recall_recipients_pkey PRIMARY KEY (id);


--
-- Name: recalls recalls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recalls
    ADD CONSTRAINT recalls_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: rfq_attachments rfq_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfq_attachments
    ADD CONSTRAINT rfq_attachments_pkey PRIMARY KEY (id);


--
-- Name: rfqs rfqs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfqs
    ADD CONSTRAINT rfqs_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: shipment_batches shipment_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_batches
    ADD CONSTRAINT shipment_batches_pkey PRIMARY KEY (shipment_id, batch_id);


--
-- Name: shipment_events shipment_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_events
    ADD CONSTRAINT shipment_events_pkey PRIMARY KEY (id);


--
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (id);


--
-- Name: batches uq_batch_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT uq_batch_number UNIQUE (batch_number);


--
-- Name: file_objects uq_file_object_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_objects
    ADD CONSTRAINT uq_file_object_key UNIQUE (object_key);


--
-- Name: machines uq_machine_serial; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT uq_machine_serial UNIQUE (organization_id, serial_number);


--
-- Name: materials uq_material_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT uq_material_name UNIQUE (material_name);


--
-- Name: production_orders uq_order_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT uq_order_number UNIQUE (order_number);


--
-- Name: production_orders uq_order_quotation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT uq_order_quotation UNIQUE (accepted_quotation_id);


--
-- Name: production_orders uq_order_rfq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT uq_order_rfq UNIQUE (rfq_id);


--
-- Name: organization_members uq_org_member; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT uq_org_member UNIQUE (organization_id, user_id);


--
-- Name: product_passports uq_passport_batch; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_passports
    ADD CONSTRAINT uq_passport_batch UNIQUE (batch_id);


--
-- Name: product_passports uq_passport_token; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_passports
    ADD CONSTRAINT uq_passport_token UNIQUE (public_token);


--
-- Name: payments uq_payment_idempotency; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT uq_payment_idempotency UNIQUE (idempotency_key);


--
-- Name: payments uq_payment_reference; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT uq_payment_reference UNIQUE (payment_reference);


--
-- Name: manufacturing_processes uq_process_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturing_processes
    ADD CONSTRAINT uq_process_name UNIQUE (process_name);


--
-- Name: quotations uq_quotation_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT uq_quotation_number UNIQUE (quotation_number);


--
-- Name: quotations uq_quotation_version; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT uq_quotation_version UNIQUE (rfq_id, manufacturer_organization_id, version_number);


--
-- Name: recall_recipients uq_recall_recipient; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recall_recipients
    ADD CONSTRAINT uq_recall_recipient UNIQUE (recall_id, organization_id);


--
-- Name: password_reset_tokens uq_reset_token_hash; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT uq_reset_token_hash UNIQUE (token_hash);


--
-- Name: reviews uq_review_per_order; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT uq_review_per_order UNIQUE (order_id, buyer_organization_id);


--
-- Name: rfqs uq_rfq_number; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfqs
    ADD CONSTRAINT uq_rfq_number UNIQUE (rfq_number);


--
-- Name: roles uq_roles_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT uq_roles_name UNIQUE (role_name);


--
-- Name: users uq_users_email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uq_users_email UNIQUE (email);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_audit_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_created ON public.audit_logs USING btree (created_at);


--
-- Name: idx_audit_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_entity ON public.audit_logs USING btree (entity_type, entity_id);


--
-- Name: idx_avail_rules_machine; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_avail_rules_machine ON public.machine_availability_rules USING btree (machine_id);


--
-- Name: idx_batches_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_batches_order ON public.batches USING btree (production_order_id);


--
-- Name: idx_disputes_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_disputes_order ON public.disputes USING btree (order_id);


--
-- Name: idx_files_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_files_org ON public.file_objects USING btree (organization_id);


--
-- Name: idx_inspections_batch; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inspections_batch ON public.inspections USING btree (batch_id);


--
-- Name: idx_inspections_inspector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inspections_inspector ON public.inspections USING btree (inspector_user_id);


--
-- Name: idx_machines_org; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_machines_org ON public.machines USING btree (organization_id);


--
-- Name: idx_maintenance_machine; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_maintenance_machine ON public.machine_maintenance_blocks USING btree (machine_id, start_at);


--
-- Name: idx_measurements_insp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_measurements_insp ON public.inspection_measurements USING btree (inspection_id);


--
-- Name: idx_notifications_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notifications_user ON public.notifications USING btree (user_id, read_at);


--
-- Name: idx_order_events_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_order_events_order ON public.production_order_events USING btree (production_order_id);


--
-- Name: idx_orders_buyer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_buyer ON public.production_orders USING btree (buyer_organization_id);


--
-- Name: idx_orders_mfr; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_orders_mfr ON public.production_orders USING btree (manufacturer_organization_id);


--
-- Name: idx_org_members_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_org_members_user ON public.organization_members USING btree (user_id);


--
-- Name: idx_org_type_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_org_type_status ON public.organizations USING btree (organization_type, verification_status);


--
-- Name: idx_payments_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payments_order ON public.payments USING btree (production_order_id);


--
-- Name: idx_quotations_mfr; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quotations_mfr ON public.quotations USING btree (manufacturer_organization_id);


--
-- Name: idx_quotations_rfq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quotations_rfq ON public.quotations USING btree (rfq_id);


--
-- Name: idx_recalls_batch; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_recalls_batch ON public.recalls USING btree (batch_id);


--
-- Name: idx_reservations_machine; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_machine ON public.machine_reservations USING btree (machine_id, start_at);


--
-- Name: idx_reservations_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_order ON public.machine_reservations USING btree (production_order_id);


--
-- Name: idx_reviews_mfr; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_mfr ON public.reviews USING btree (manufacturer_organization_id);


--
-- Name: idx_rfqs_buyer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rfqs_buyer ON public.rfqs USING btree (buyer_organization_id);


--
-- Name: idx_rfqs_match; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rfqs_match ON public.rfqs USING btree (process_id, material_id, status);


--
-- Name: idx_shipment_events_ship; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_shipment_events_ship ON public.shipment_events USING btree (shipment_id, event_time);


--
-- Name: idx_shipments_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_shipments_order ON public.shipments USING btree (production_order_id);


--
-- Name: audit_logs audit_logs_actor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_actor_user_id_fkey FOREIGN KEY (actor_user_id) REFERENCES public.users(id);


--
-- Name: batches batches_production_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_production_order_id_fkey FOREIGN KEY (production_order_id) REFERENCES public.production_orders(id);


--
-- Name: disputes disputes_opened_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disputes
    ADD CONSTRAINT disputes_opened_by_fkey FOREIGN KEY (opened_by) REFERENCES public.users(id);


--
-- Name: disputes disputes_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disputes
    ADD CONSTRAINT disputes_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.production_orders(id);


--
-- Name: disputes disputes_resolved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disputes
    ADD CONSTRAINT disputes_resolved_by_fkey FOREIGN KEY (resolved_by) REFERENCES public.users(id);


--
-- Name: file_objects file_objects_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_objects
    ADD CONSTRAINT file_objects_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: file_objects file_objects_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_objects
    ADD CONSTRAINT file_objects_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- Name: inspection_measurements inspection_measurements_inspection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspection_measurements
    ADD CONSTRAINT inspection_measurements_inspection_id_fkey FOREIGN KEY (inspection_id) REFERENCES public.inspections(id) ON DELETE CASCADE;


--
-- Name: inspections inspections_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id);


--
-- Name: inspections inspections_inspector_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inspections
    ADD CONSTRAINT inspections_inspector_user_id_fkey FOREIGN KEY (inspector_user_id) REFERENCES public.users(id);


--
-- Name: machine_availability_rules machine_availability_rules_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_availability_rules
    ADD CONSTRAINT machine_availability_rules_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id) ON DELETE CASCADE;


--
-- Name: machine_maintenance_blocks machine_maintenance_blocks_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_maintenance_blocks
    ADD CONSTRAINT machine_maintenance_blocks_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id) ON DELETE CASCADE;


--
-- Name: machine_materials machine_materials_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_materials
    ADD CONSTRAINT machine_materials_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id) ON DELETE CASCADE;


--
-- Name: machine_materials machine_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_materials
    ADD CONSTRAINT machine_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: machine_processes machine_processes_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_processes
    ADD CONSTRAINT machine_processes_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id) ON DELETE CASCADE;


--
-- Name: machine_processes machine_processes_process_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_processes
    ADD CONSTRAINT machine_processes_process_id_fkey FOREIGN KEY (process_id) REFERENCES public.manufacturing_processes(id);


--
-- Name: machine_reservations machine_reservations_machine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_reservations
    ADD CONSTRAINT machine_reservations_machine_id_fkey FOREIGN KEY (machine_id) REFERENCES public.machines(id);


--
-- Name: machine_reservations machine_reservations_production_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_reservations
    ADD CONSTRAINT machine_reservations_production_order_id_fkey FOREIGN KEY (production_order_id) REFERENCES public.production_orders(id);


--
-- Name: machine_reservations machine_reservations_reserved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machine_reservations
    ADD CONSTRAINT machine_reservations_reserved_by_fkey FOREIGN KEY (reserved_by) REFERENCES public.users(id);


--
-- Name: machines machines_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.machines
    ADD CONSTRAINT machines_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: manufacturer_materials manufacturer_materials_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_materials
    ADD CONSTRAINT manufacturer_materials_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer_profiles(organization_id) ON DELETE CASCADE;


--
-- Name: manufacturer_materials manufacturer_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_materials
    ADD CONSTRAINT manufacturer_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: manufacturer_processes manufacturer_processes_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_processes
    ADD CONSTRAINT manufacturer_processes_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer_profiles(organization_id) ON DELETE CASCADE;


--
-- Name: manufacturer_processes manufacturer_processes_process_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_processes
    ADD CONSTRAINT manufacturer_processes_process_id_fkey FOREIGN KEY (process_id) REFERENCES public.manufacturing_processes(id);


--
-- Name: manufacturer_profiles manufacturer_profiles_approved_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_profiles
    ADD CONSTRAINT manufacturer_profiles_approved_by_fkey FOREIGN KEY (approved_by) REFERENCES public.users(id);


--
-- Name: manufacturer_profiles manufacturer_profiles_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_profiles
    ADD CONSTRAINT manufacturer_profiles_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: organization_members organization_members_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- Name: organization_members organization_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_members
    ADD CONSTRAINT organization_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: password_reset_tokens password_reset_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: payments payments_production_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_production_order_id_fkey FOREIGN KEY (production_order_id) REFERENCES public.production_orders(id);


--
-- Name: product_passports product_passports_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_passports
    ADD CONSTRAINT product_passports_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id);


--
-- Name: production_order_events production_order_events_production_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_order_events
    ADD CONSTRAINT production_order_events_production_order_id_fkey FOREIGN KEY (production_order_id) REFERENCES public.production_orders(id) ON DELETE CASCADE;


--
-- Name: production_order_events production_order_events_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_order_events
    ADD CONSTRAINT production_order_events_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- Name: production_orders production_orders_accepted_quotation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_accepted_quotation_id_fkey FOREIGN KEY (accepted_quotation_id) REFERENCES public.quotations(id);


--
-- Name: production_orders production_orders_buyer_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_buyer_organization_id_fkey FOREIGN KEY (buyer_organization_id) REFERENCES public.organizations(id);


--
-- Name: production_orders production_orders_manufacturer_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_manufacturer_organization_id_fkey FOREIGN KEY (manufacturer_organization_id) REFERENCES public.organizations(id);


--
-- Name: production_orders production_orders_rfq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.production_orders
    ADD CONSTRAINT production_orders_rfq_id_fkey FOREIGN KEY (rfq_id) REFERENCES public.rfqs(id);


--
-- Name: quotations quotations_manufacturer_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_manufacturer_organization_id_fkey FOREIGN KEY (manufacturer_organization_id) REFERENCES public.organizations(id);


--
-- Name: quotations quotations_rfq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_rfq_id_fkey FOREIGN KEY (rfq_id) REFERENCES public.rfqs(id);


--
-- Name: quotations quotations_submitted_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quotations
    ADD CONSTRAINT quotations_submitted_by_fkey FOREIGN KEY (submitted_by) REFERENCES public.users(id);


--
-- Name: recall_recipients recall_recipients_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recall_recipients
    ADD CONSTRAINT recall_recipients_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: recall_recipients recall_recipients_recall_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recall_recipients
    ADD CONSTRAINT recall_recipients_recall_id_fkey FOREIGN KEY (recall_id) REFERENCES public.recalls(id) ON DELETE CASCADE;


--
-- Name: recalls recalls_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recalls
    ADD CONSTRAINT recalls_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id);


--
-- Name: recalls recalls_initiated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recalls
    ADD CONSTRAINT recalls_initiated_by_fkey FOREIGN KEY (initiated_by) REFERENCES public.users(id);


--
-- Name: reviews reviews_buyer_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_buyer_organization_id_fkey FOREIGN KEY (buyer_organization_id) REFERENCES public.organizations(id);


--
-- Name: reviews reviews_manufacturer_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_manufacturer_organization_id_fkey FOREIGN KEY (manufacturer_organization_id) REFERENCES public.organizations(id);


--
-- Name: reviews reviews_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.production_orders(id);


--
-- Name: reviews reviews_reviewer_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_reviewer_user_id_fkey FOREIGN KEY (reviewer_user_id) REFERENCES public.users(id);


--
-- Name: rfq_attachments rfq_attachments_file_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfq_attachments
    ADD CONSTRAINT rfq_attachments_file_id_fkey FOREIGN KEY (file_id) REFERENCES public.file_objects(id);


--
-- Name: rfq_attachments rfq_attachments_rfq_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfq_attachments
    ADD CONSTRAINT rfq_attachments_rfq_id_fkey FOREIGN KEY (rfq_id) REFERENCES public.rfqs(id) ON DELETE CASCADE;


--
-- Name: rfq_attachments rfq_attachments_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfq_attachments
    ADD CONSTRAINT rfq_attachments_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- Name: rfqs rfqs_buyer_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfqs
    ADD CONSTRAINT rfqs_buyer_organization_id_fkey FOREIGN KEY (buyer_organization_id) REFERENCES public.organizations(id);


--
-- Name: rfqs rfqs_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfqs
    ADD CONSTRAINT rfqs_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: rfqs rfqs_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfqs
    ADD CONSTRAINT rfqs_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: rfqs rfqs_process_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rfqs
    ADD CONSTRAINT rfqs_process_id_fkey FOREIGN KEY (process_id) REFERENCES public.manufacturing_processes(id);


--
-- Name: shipment_batches shipment_batches_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_batches
    ADD CONSTRAINT shipment_batches_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.batches(id);


--
-- Name: shipment_batches shipment_batches_shipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_batches
    ADD CONSTRAINT shipment_batches_shipment_id_fkey FOREIGN KEY (shipment_id) REFERENCES public.shipments(id) ON DELETE CASCADE;


--
-- Name: shipment_events shipment_events_shipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipment_events
    ADD CONSTRAINT shipment_events_shipment_id_fkey FOREIGN KEY (shipment_id) REFERENCES public.shipments(id) ON DELETE CASCADE;


--
-- Name: shipments shipments_production_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_production_order_id_fkey FOREIGN KEY (production_order_id) REFERENCES public.production_orders(id);


--
-- Name: user_roles user_roles_assigned_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_assigned_by_fkey FOREIGN KEY (assigned_by) REFERENCES public.users(id);


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict DFcRjVlSZKgIJHEuclY9tEfVzaVYREHOnpISf1gQOVm8FNXhsYDjW3Iv077pDQG

